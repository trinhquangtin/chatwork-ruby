module ChatWork
  class BaseClient
    include Converter

    # @param api_base [String]
    # @param api_version [String]
    # @param header [Hash<String,String>]
    def initialize(api_base:, api_version: "", header:)
      default_header = {
        "User-Agent" => "ChatWork#{api_version} RubyBinding/#{ChatWork::VERSION}",
      }

      default_header.merge!(header)

      @conn = Faraday.new(api_base, headers: default_header) do |builder|
        builder.ssl[:verify] = false
        builder.request :chatwork_multipart
        builder.request :url_encoded
        builder.response :mashify
        builder.response :json
        builder.adapter Faraday.default_adapter
      end
      @api_version = api_version
    end

    def handle_response(response)
      case response.status
      when 200..299
        response.body
      else
        raise ChatWork::ChatWorkError.from_response(response.status, response.body, response.headers)
      end
    end

    Faraday::Connection::METHODS.each do |method|
      define_method(method) do |url, args = {}, &block|
        begin
          response = @conn.__send__(method, @api_version + url, args.compact)
        rescue Faraday::ClientError, Faraday::ServerError => e
          raise ChatWork::APIConnectionError.faraday_error(e)
        end
        payload = handle_response(response)
        block.call(payload, response.headers) if block
        payload
      end
    end
  end
end

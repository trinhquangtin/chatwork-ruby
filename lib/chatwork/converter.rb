module ChatWork
  module Converter
    def hash_compact(hash)
      hash.compact
    end

    def boolean_to_integer(value)
      case value
      when true
        1
      when false
        0
      else
        value
      end
    end
  end
end

describe ChatWork::Client::MeMethods do
  describe "get_me", type: :api do
    subject { client.get_me(&block) }

    before do
      stub_chatwork_request(:get, "/me")
    end

    it_behaves_like :a_chatwork_api, :get, "/me"

    context "when unauthorized" do
      before do
        stub_chatwork_request(:get, "/me", "/me", 401)
      end

      let(:block) { nil }

      it { expect { subject }.to raise_error(ChatWork::APIError, "Invalid API token") }
    end
  end
end

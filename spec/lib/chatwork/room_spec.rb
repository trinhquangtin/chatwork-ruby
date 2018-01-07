describe ChatWork::Room do
  describe ".get", type: :api do
    subject { ChatWork::Room.get }

    let(:room_id) { 123 }

    before do
      stub_chatwork_request(:get, "/rooms")
    end

    it_behaves_like :a_chatwork_api, :get, "/rooms"
  end

  describe ".create", type: :api do
    subject do
      ChatWork::Room.create(
        description:          description,
        icon_preset:          icon_preset,
        members_admin_ids:    members_admin_ids,
        members_member_ids:   members_member_ids,
        members_readonly_ids: members_readonly_ids,
        name:                 name,
      )
    end

    let(:description)          { "group chat description" }
    let(:icon_preset)          { "meeting" }
    let(:members_admin_ids)    { "123,542,1001" }
    let(:members_member_ids)   { "21,344" }
    let(:members_readonly_ids) { "15,103" }
    let(:name)                 { "Website renewal project" }

    before do
      stub_chatwork_request(:post, "/rooms")
    end

    it_behaves_like :a_chatwork_api, :post, "/rooms"
  end
end

describe 'admin permissions' do

  subject { PermissionService.new(build(:admin)) }
  let(:permission_service) { subject }

  describe 'as admin' do
    it 'allows anything' do
      is_expected.to allow_action(:anything, :here)
      is_expected.to allow_attribute(:anything, :here)
    end
  end
end
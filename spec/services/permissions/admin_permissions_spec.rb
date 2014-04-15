describe 'admin permissions' do

  subject { PermissionService.new(build(:admin)) }
  let(:permission_service) { subject }

  describe 'as admin' do
    it 'allows anything' do
      should allow_action(:anything, :here)
      should allow_attribute(:anything, :here)
    end
  end
end
describe ProfilesShowPresenter do

  let(:user) { build(:user) }
  let(:current_user_id) { user.id }
  subject { ProfilesShowPresenter.new(user: user, current_user_id: current_user_id) }

  it 'should respond to user' do
    subject.should respond_to :user
  end

  
end
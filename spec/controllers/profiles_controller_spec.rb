describe ProfilesController, :type => :controller do

  let(:requested_user) { create(:player) }
  let(:sign_in_user) { create(:player) }

  before :each do
    sign_in sign_in_user
  end

  describe '#show' do

    it 'should return http success' do
      get :show, params: {id: requested_user.id}
      expect(response).to be_success
    end

    it 'should render template show' do
      get :show, params: {id: requested_user.id}
      expect(response).to render_template :show
    end

    it 'should assign correctly instantiated ProfilesShowPresenter' do
      expect(User).to receive(:find_player).with(requested_user.to_param).and_return(requested_user)
      expect(@controller).to receive(:is_user_current_user?).with(requested_user).and_return(false)

      expect(ProfilesShowPresenter).to receive(:new).
          with(user: requested_user,
               tournament: @controller.tournament,
               is_for_current_user: false,
               section: 'statistic').and_call_original

      expect_any_instance_of(FindUserBadges).to receive(:run)

      get :show, params: {id: requested_user.id, section: 'statistic'}
    end
  end
end

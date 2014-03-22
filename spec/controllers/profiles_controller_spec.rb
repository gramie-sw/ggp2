describe ProfilesController do

  let(:requested_user) { create(:player) }
  let(:sign_in_user) { create(:player) }

  before :each do
    sign_in sign_in_user
  end

  describe '#show' do

    it 'should return http success' do
      get :show, id: requested_user.id
      response.should be_success
    end

    it 'should render template show' do
      get :show, id: requested_user.id
      response.should render_template :show
    end

    it 'should assign correctly instantiated ProfilesShowPresenter' do
      User.should_receive(:find_player).with(requested_user.to_param).and_return(requested_user)
      @controller.should_receive(:is_user_current_user?).with(requested_user).and_return(false)
      ProfilesShowPresenter.should_receive(:new).
          with(user: requested_user,
               tournament: @controller.tournament,
               is_for_current_user: false,
               section: 'statistic').and_call_original
      get :show, id: requested_user.id, section: 'statistic'
    end
  end
end

describe ProfilesController do

  let(:requested_player) { create(:player) }
  let(:sign_in_player) { create(:player) }

  before :each do
    sign_in sign_in_player
  end

  describe '#show' do

    it 'should return http success' do
      get :show, id: requested_player.id
      response.should be_success
    end

    it 'should render template show' do
      get :show, id: requested_player.id
      response.should render_template :show
    end

    it 'should assign correctly instantiated ProfilesShowPresenter' do
      User.should_receive(:find_player).with(requested_player.to_param).and_return(requested_player)
      ProfilesShowPresenter.should_receive(:new).
          with(user: requested_player, current_user_id: sign_in_player.id).and_call_original
      get :show, id: requested_player.id
    end
  end
end

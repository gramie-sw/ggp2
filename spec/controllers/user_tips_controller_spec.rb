describe UserTipsController do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#show' do

    it 'should return http success' do
      get :show, id: player.to_param
      response.should be_success
    end

    it 'should render template show' do
      get :show, id: player.to_param
      response.should render_template :show
    end

    it 'should assign UserTipsShowPresenter' do
      UserTipsShowPresenter.should_receive(:new).with(user_id: player.to_param).and_call_original
      get :show, id: player.to_param
      assigns(:presenter).should be_kind_of UserTipsShowPresenter
    end
  end

end

describe MatchTipsController do

  let(:player) { create(:player) }
  let(:match) { create(:match) }

  before :each do
    sign_in player
  end

  describe '#show' do

    it 'should returns http success' do
      get :show, id: match.to_param
      response.should be_success
    end

    it 'should render show' do
      get :show, id: match.to_param
      response.should render_template :show
    end

    it 'should assign correctly instantiated MatchTipsShowPresenter' do
      MatchTipsShowPresenter.should_receive(:new).with(match: match, current_user_id: player.id).and_call_original
      get :show, id: match.to_param
      assigns(:presenter).should be_kind_of MatchTipsShowPresenter
    end
  end

end

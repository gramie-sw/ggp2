describe MatchTipsController, :type => :controller do

  let(:player) { create(:player) }
  let(:match) { create(:match) }

  before :each do
    sign_in player
  end

  describe '#show' do

    it 'should returns http success' do
      get :show, id: match.to_param
      expect(response).to be_success
    end

    it 'should render show' do
      get :show, id: match.to_param
      expect(response).to render_template :show
    end

    it 'should assign correctly instantiated MatchTipsShowPresenter' do
      expect(MatchTipsShowPresenter).to receive(:new).
          with(match: match, current_user_id: player.id, page: '2').and_call_original
      get :show,{id: match.to_param, page: 2}
      expect(assigns(:presenter)).to be_kind_of MatchTipsShowPresenter
    end
  end

end

describe TeamsController, :type => :controller do

  before :each do
    create_and_sign_in :admin
  end

  describe '#index' do
    it 'should return http success' do
      get :index
      expect(response).to be_success
    end

    it 'should render index' do
      get :index
      expect(response).to render_template :index
    end

    it 'should assign @presenter' do
      expect(TeamsIndexPresenter).to receive(:new).with(no_args).and_call_original
      get :index
      expect(assigns(:presenter)).to be_an_instance_of TeamsIndexPresenter
    end
  end

  describe '#create' do

    let(:params) { { team: { country: 'ZZ' }}}

    context 'if successful' do
      it 'should redirect to index' do
        post :create, params
        expect(response).to redirect_to teams_path
      end

      it 'should create team with values from params' do
        post :create, params
        expect(assigns(:team)).not_to be_a_new Match
        expect(assigns(:team).country).to eq 'ZZ'
      end

      it 'should assign flash notice' do
        post :create, params
        expect(flash[:notice]).to eq t('model.messages.created', model: assigns(:team).message_country_name)
      end
    end

    context 'if failing' do

      before :each do
        allow_any_instance_of(Team).to receive(:valid?).and_return false
      end

      it 'should render index' do
        post :create, params
        expect(response).to render_template :index
      end

      it 'should assign @team' do
        post :create, params
        expect(assigns(:team)).to be_a_new(Team)
        expect(assigns(:team).country).to eq 'ZZ'
      end
    end
  end

  describe '#destroy' do

    let(:team) { create(:team) }

    it '#should redirect to index' do
      delete :destroy, id: team.to_param
      expect(response).to redirect_to teams_path
    end

    it '#should destroy team' do
      delete :destroy, id: team.to_param
      expect(Team.exists?(team)).to be_falsey
    end

    it '#should assign flash notice' do
      delete :destroy, id: team.to_param
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: assigns(:team).message_country_name)
    end
  end
end
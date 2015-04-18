describe MatchesController, :type => :controller do

  before :each do
    create_and_sign_in :admin
  end

  describe '#new' do
    it 'should return http success' do
      get :new
      expect(response).to be_success
    end

    it 'should render template new' do
      get :new
      expect(response).to render_template :new
    end

    it 'should assign @matches' do
      get :new
      expect(assigns(:match)).to be_a_new Match
    end
  end

  describe '#create' do

    context 'if successful' do
      let(:aggregate) { create(:aggregate) }
      let(:params) { {match: {position: 1, aggregate_id: aggregate.id, placeholder_team_1: 'Team1', placeholder_team_2: 'Team 2', date: Time.now}} }

      it 'should redirect to match_schedules_path' do
        post :create, params
        expect(response).to redirect_to match_schedules_path(aggregate_id: aggregate.to_param)
      end

      it 'should create match with values from params' do
        post :create, params
        expect(assigns(:match)).not_to be_a_new Match
        expect(assigns(:match).position).to eq 1
      end

      it 'should assign notice flash message' do
        post :create, params
        expect(flash[:notice]).to eq t('model.messages.added', model: assigns(:match).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {match: {position: 1, aggregate_id: 2, placeholder_team_1: 'Team1', placeholder_team_2: 'Team 2', date: Time.now}} }

      before :each do
        allow_any_instance_of(Aggregate).to receive(:valid?).and_return(false)
      end

      it 'should render new' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'should assign @match' do
        post :create, params
        expect(assigns(:match)).to be_a_new Match
        expect(assigns(:match).position).to eq 1
      end
    end
  end

  describe '#edit' do

    let(:match) { create(:match) }

    it 'should return http success' do
      get :edit, id: match.to_param
      expect(response).to be_success
    end

    it 'should render template edit' do
      get :edit, id: match.to_param
      expect(response).to render_template :edit
    end

    it 'should assign @match' do
      get :edit, id: match.to_param
      expect(assigns(:match)).to eq match
    end
  end

  describe '#update' do

    let(:match) { create(:match) }

    context 'if successful' do

      let(:params) { {id: match.to_param, match: {placeholder_team_1: 'Team 1 Updated', placeholder_team_2: 'Team 2 Updated'}}}

      it 'should redirect to match_schedules_path' do
        patch :update, params
        expect(response).to redirect_to match_schedules_path(aggregate_id: match.aggregate_id)
      end

      it 'should update match with given params' do
        patch :update, params
        expect(assigns(:match).placeholder_team_1).to eq 'Team 1 Updated'
        expect(assigns(:match).placeholder_team_2).to eq 'Team 2 Updated'
      end

      it 'should assign flash notice' do
        patch :update, params
        expect(flash[:notice]).to eq t('model.messages.updated', model: assigns(:match).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {id: match.to_param, match: {position: -1}}}

      it 'should render edit' do
        patch :update, params
        expect(response).to render_template :edit
      end

      it 'should assign @match' do
        patch :update, params
        expect(assigns(:match)).to eq match
      end
    end
  end

  describe '#destroy' do

    let(:match) { create(:match) }

    it 'should redirect to index' do
      delete :destroy, id: match.to_param
      expect(response).to redirect_to matches_path
    end

    it 'should destroy match' do
      delete :destroy, id: match.to_param
      expect(Match.exists?(match.id)).to be_falsey
    end

    it 'should assign flash notice' do
      delete :destroy, id: match.to_param
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: match.message_name)
    end
  end
end
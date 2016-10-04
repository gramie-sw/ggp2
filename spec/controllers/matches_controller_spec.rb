describe MatchesController, :type => :controller do

  before :each do
    create_and_sign_in :admin
  end

  describe '#new' do

    it 'assigns matches with set aggregate_id and renders template new' do
      expected_aggregate_id = 783

      get :new, params: {aggregate_id: expected_aggregate_id}

      expect(response).to be_success
      match = assigns(:match)
      expect(match).to be_a_new Match
      expect(match.aggregate_id).to eq expected_aggregate_id
      expect(response).to render_template :new
    end
  end

  describe '#create' do

    let(:match) { Match.new(position: 223, aggregate_id: 453) }
    let(:match_attributes) { {'match_key' => 'match_value'} }
    let(:params) { {match: match_attributes} }

    before :each do
      expect(Matches::Create).to receive(:run).
          with(match_attributes: ActionController::Parameters.new(match_attributes).permit!).
          and_return(match)
    end

    context 'on successful' do


      it 'creates match with values from params' do
        post :create, params: params
        expect(assigns(:match)).to be match
      end

      let(:notice_message) { t('model.messages.added', model: assigns(:match).message_name) }

      context 'if subsequent_match is not present in params^' do

        it 'redirects to match_schedules_path' do
          post :create, params: params
          expect(response).to redirect_to match_schedules_path(aggregate_id: match.aggregate_id)
          expect(flash[:notice]).to eq notice_message
        end
      end

      context 'if subsequent_match is present in params' do

        it 'redirects to match_schedules_path' do
          params[:subsequent_match] = '1'
          post :create, params: params
          expect(response).to redirect_to new_match_path(aggregate_id: match.aggregate_id)
          expect(flash[:notice]).to eq notice_message
        end
      end
    end

    context 'on failure' do

      before :each do
        match.errors.add(:base, 'error')
      end

      it 'should render new' do
        post :create, params: params
        expect(response).to render_template :new
      end

      it 'should assign match' do
        post :create, params: params
        expect(assigns(:match)).to be match
      end
    end
  end

  describe '#edit' do

    let(:match) { create(:match) }

    it 'should return http success' do
      get :edit, params: {id: match.to_param}
      expect(response).to be_success
    end

    it 'should render template edit' do
      get :edit, params: {id: match.to_param}
      expect(response).to render_template :edit
    end

    it 'should assign @match' do
      get :edit, params: {id: match.to_param}
      expect(assigns(:match)).to eq match
    end
  end

  describe '#update' do

    let(:match) { create(:match) }

    context 'if successful' do

      let(:params) { {id: match.to_param, match: {placeholder_team_1: 'Team 1 Updated', placeholder_team_2: 'Team 2 Updated'}} }

      it 'should redirect to match_schedules_path' do
        patch :update, params: params
        expect(response).to redirect_to match_schedules_path(aggregate_id: match.aggregate_id)
      end

      it 'should update match with given params' do
        patch :update, params: params
        expect(assigns(:match).placeholder_team_1).to eq 'Team 1 Updated'
        expect(assigns(:match).placeholder_team_2).to eq 'Team 2 Updated'
      end

      it 'should assign flash notice' do
        patch :update, params: params
        expect(flash[:notice]).to eq t('model.messages.updated', model: assigns(:match).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {id: match.to_param, match: {position: -1}} }

      it 'should render edit' do
        patch :update, params: params
        expect(response).to render_template :edit
      end

      it 'should assign @match' do
        patch :update, params: params
        expect(assigns(:match)).to eq match
      end
    end
  end

  describe '#destroy' do

    let(:match) { Match.new(id: 567) }

    before :each do
      allow(Match).to receive(:find).and_return(match)
    end

    it 'should destroy match' do
      expect(Match).to receive(:find).with(match.to_param).and_return(match)
      expect(match).to receive(:destroy)
      delete :destroy, params: {id: match.to_param}
      expect(Match.exists?(match.id)).to be_falsey
    end

    it 'should redirect to match_schedule_path and assign flash notice' do
      delete :destroy, params: {id: match.to_param}
      expect(response).to redirect_to match_schedules_path
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: match.message_name)
    end
  end
end
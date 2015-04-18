describe MatchResultsController, :type => :controller do

  let(:admin) { create(:admin) }

  before :each do
    sign_in admin
  end

  describe '#new' do

    let(:match) { create(:match)}

    it 'should render http success' do
      get :new, match_id: match.id
      expect(response).to be_success
    end

    it 'should render new' do
      get :new, match_id: match.id
      expect(response).to render_template :new
    end

    it 'should assign @match_result_presenter' do
      get :new, match_id: match.id
      assigns(:match_result_presenter).kind_of? MatchResultPresenter
      expect(assigns(:match_result_presenter).match_id).to eq match.id.to_s
    end
  end

  describe '#create' do

    let(:match) { create(:match)}

    context 'when successful' do

      let(:params) { {match_result: { match_id: match.id, score_team_1: 2, score_team_2: 2 }}}

      it 'should redirect to matches index' do
        post :create, params
        expect(response).to redirect_to match_schedules_path(aggregate_id: match.aggregate_id)
      end

      it 'should call save on @match_result'  do
        expect_any_instance_of(MatchResult).to receive(:save).with(no_args).and_call_original
        post :create, params
      end

      it 'should run uc ProcessNewMatchResult with given match id' do
        expect_any_instance_of(MatchResult).to receive(:save).with(no_args).and_return(true)
        expect_any_instance_of(ProcessNewMatchResult).to receive(:run).with(match.id)
        post :create, params
      end

      it 'should run uc UpdateUserBadges with given group (:tip)' do
        expect_any_instance_of(MatchResult).to receive(:save).with(no_args).and_return(true)
        expect_any_instance_of(UpdateUserBadges).to receive(:run)
        post :create, params
      end

      it 'should assign flash notice' do
        post :create, params
        expect(flash[:notice]).to eq t('model.messages.updated', model: assigns(:match_result).message_name)
      end
    end

    context 'when failing' do

      let(:params) { {match_result: { match_id: match.id, score_team_1: 2 }}}

      it 'should render new' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'should assign @match_result_presenter' do
        post :create, params
        expect(assigns[:match_result_presenter].score_team_1).to eq 2.to_s
      end
    end
  end
end
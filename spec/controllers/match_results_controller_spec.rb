describe MatchResultsController do

  let(:admin) { create(:admin) }

  before :each do
    sign_in admin
  end

  describe '#new' do

    let(:match) { create(:match)}

    it 'should render http success' do
      get :new, match_id: match.id
      response.should be_success
    end

    it 'should render new' do
      get :new, match_id: match.id
      response.should render_template :new
    end

    it 'should assign @match_result_presenter' do
      get :new, match_id: match.id
      assigns(:match_result_presenter).kind_of? MatchResultPresenter
      assigns(:match_result_presenter).match_id.should eq match.id.to_s
    end
  end

  describe '#create' do

    let(:match) { create(:match)}

    context 'when successful' do

      let(:params) { {match_result: { match_id: match.id, score_team_1: 2, score_team_2: 2 }}}

      it 'should redirect to matches index' do
        post :create, params
        response.should redirect_to matches_path
      end

      it 'should call save on @match_result'  do
        MatchResult.any_instance.should_receive(:save).with(no_args).and_call_original
        post :create, params
      end

      it 'should run uc ProcessNewMatchResult with given match id' do
        MatchResult.any_instance.should_receive(:save).with(no_args).and_return(true)
        ProcessNewMatchResult.any_instance.should_receive(:run).with(match.id)
        post :create, params
      end

      it 'should assign flash notice' do
        post :create, params
        flash[:notice].should eq t('model.messages.updated', model: assigns(:match_result).message_name)
      end
    end

    context 'when failing' do

      let(:params) { {match_result: { match_id: match.id, score_team_1: 2 }}}

      it 'should render new' do
        post :create, params
        response.should render_template :new
      end

      it 'should assign @match_result_presenter' do
        post :create, params
        assigns[:match_result_presenter].score_team_1.should eq 2.to_s
      end
    end
  end
end
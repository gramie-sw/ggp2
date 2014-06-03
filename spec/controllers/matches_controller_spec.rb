describe MatchesController do

  before :each do
    create_and_sign_in :admin
  end

  describe '#index' do
    it 'should return success' do
      get :index
      response.should be_success
    end

    it 'should render index' do
      get :index
      response.should render_template :index
    end

    it 'should assign @presenter' do
      MatchesIndexPresenter.should_receive(:new).with(no_args).and_call_original
      get :index
      assigns(:presenter).should be_an_instance_of MatchesIndexPresenter
    end
  end

  describe '#new' do
    it 'should return http success' do
      get :new
      response.should be_success
    end

    it 'should render template new' do
      get :new
      response.should render_template :new
    end

    it 'should assign @matches' do
      get :new
      assigns(:match).should be_a_new Match
    end
  end

  describe '#create' do
    context 'if successful' do
      let(:aggregate) { create(:aggregate) }
      let(:params) { {match: {position: 1, aggregate_id: aggregate.id, placeholder_team_1: 'Team1', placeholder_team_2: 'Team 2', date: Time.now}} }

      it 'should redirect to index' do
        post :create, params
        response.should redirect_to matches_path
      end

      it 'should create match with values from params' do
        post :create, params
        assigns(:match).should_not be_a_new Match
        assigns(:match).position.should eq 1
      end

      it 'should assign notice flash message' do
        post :create, params
        flash[:notice].should eq t('model.messages.added', model: assigns(:match).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {match: {position: 1, aggregate_id: 2, placeholder_team_1: 'Team1', placeholder_team_2: 'Team 2', date: Time.now}} }

      before :each do
        Aggregate.any_instance.stub(:valid?).and_return(false)
      end

      it 'should render new' do
        post :create, params
        response.should render_template :new
      end

      it 'should assign @match' do
        post :create, params
        assigns(:match).should be_a_new Match
        assigns(:match).position.should eq 1
      end
    end
  end

  describe '#edit' do

    let(:match) { create(:match) }

    it 'should return http success' do
      get :edit, id: match.to_param
      response.should be_success
    end

    it 'should render template edit' do
      get :edit, id: match.to_param
      response.should render_template :edit
    end

    it 'should assign @match' do
      get :edit, id: match.to_param
      assigns(:match).should eq match
    end
  end

  describe '#update' do
    let(:match) { create(:match) }

    context 'if successful' do

      let(:params) { {id: match.to_param, match: {placeholder_team_1: 'Team 1 Updated', placeholder_team_2: 'Team 2 Updated'}}}

      it 'should redirect to index' do
        patch :update, params
        response.should redirect_to matches_path
      end

      it 'should update match with given params' do
        patch :update, params
        assigns(:match).placeholder_team_1.should eq 'Team 1 Updated'
        assigns(:match).placeholder_team_2.should eq 'Team 2 Updated'
      end

      it 'should assign flash notice' do
        patch :update, params
        flash[:notice].should eq t('model.messages.updated', model: assigns(:match).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {id: match.to_param, match: {position: -1}}}

      it 'should render edit' do
        patch :update, params
        response.should render_template :edit
      end

      it 'should assign @match' do
        patch :update, params
        assigns(:match).should eq match
      end
    end
  end

  describe '#destroy' do

    let(:match) { create(:match) }

    it 'should redirect to index' do
      delete :destroy, id: match.to_param
      response.should redirect_to matches_path
    end

    it 'should destroy match' do
      delete :destroy, id: match.to_param
      Match.exists?(match).should be_false
    end

    it 'should assign flash notice' do
      delete :destroy, id: match.to_param
      flash[:notice].should eq t('model.messages.destroyed', model: match.message_name)
    end
  end
end
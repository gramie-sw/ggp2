describe TeamsController do

  let(:admin) { create(:admin) }

  before :each do
    sign_in admin
  end

  describe '#index' do
    it 'should return http success' do
      get :index
      response.should be_success
    end

    it 'should render index' do
      get :index
      response.should render_template :index
    end

    it 'should assign @presenter' do
      TeamsIndexPresenter.should_receive(:new).with(no_args).and_call_original
      get :index
      assigns(:presenter).should be_an_instance_of TeamsIndexPresenter
    end
  end

  describe '#create' do

    let(:params) { { team: { country: 'ZZ' }}}

    context 'if successful' do
      it 'should redirect to index' do
        post :create, params
        response.should redirect_to teams_path
      end

      it 'should create team with values from params' do
        post :create, params
        assigns(:team).should_not be_a_new Match
        assigns(:team).country.should eq 'ZZ'
      end

      it 'should assign flash notice' do
        post :create, params
        flash[:notice].should eq t('model.messages.created', model: assigns(:team).message_country_name)
      end
    end

    context 'if failing' do

      before :each do
        Team.any_instance.stub(:valid?).and_return false
      end

      it 'should render index' do
        post :create, params
        response.should render_template :index
      end

      it 'should assign @team' do
        post :create, params
        assigns(:team).should be_a_new(Team)
        assigns(:team).country.should eq 'ZZ'
      end
    end
  end

  describe '#destroy' do

    let(:team) { create(:team) }

    it '#should redirect to index' do
      delete :destroy, id: team.to_param
      response.should redirect_to teams_path
    end

    it '#should destroy team' do
      delete :destroy, id: team.to_param
      Team.exists?(team).should be_false
    end

    it '#should assign flash notice' do
      delete :destroy, id: team.to_param
      flash[:notice].should eq t('model.messages.destroyed', model: assigns(:team).message_country_name)
    end
  end
end
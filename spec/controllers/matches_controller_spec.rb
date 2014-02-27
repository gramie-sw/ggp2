describe MatchesController do

  let(:admin) { create(:admin) }

  before :each do
    sign_in admin
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

    end

    context 'if failing' do

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

  end

  describe '#destroy' do

    let(:match) { create(:match) }

    it 'should redirect to index' do
      delete :destroy, id: match.to_param
      response.should redirect_to matches_path
    end

    it 'should delete match' do
      delete :destroy, id: match.to_param
      Match.exists?(match.id).should be_false
    end

    it 'should assign flash notice' do
      delete :destroy, id: match.to_param
      flash[:notice].should eq t('model.messages.destroyed', model: match.message_name)
    end
  end
end
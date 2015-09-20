describe UsersController, :type => :controller do

  before :each do
    create_and_sign_in :admin
  end

  describe '#index' do

    params = {type: User::TYPES[:admin], page: '3'}

    before :each do
      allow(Users::FindAllByType).to receive(:run).and_return(:users)
    end

    it 'calls Users::FindAllByType and assigns UsersIndexPresenter' do
      expect(Users::FindAllByType).to receive(:run).with(type: params[:type], page: params[:page]).and_return(:users)
      get :index, params
    end

    it 'assigns UserIndexPresenter and renders index' do
      expect(UsersIndexPresenter).to receive(:new).with(:users, params[:type]).and_return(:presenter)
      get :index, params
      expect(assigns[:presenter]).to be :presenter
      expect(response).to be_success
      expect(response).to render_template :index
    end
  end

  describe '#create' do

    let(:user) { User.new }
    let(:params) { {user: {'email' => 'test@mail.de'}} }
    let(:result) { Users::Create::ResultWithToken.new(user, 'raw_token') }

    before :each do
      allow(Users::Create).to receive(:run).and_return(result)
    end

    it 'passes correct params to User::Create' do
      expect(Users::Create).to receive(:run).with(user_attributes: params[:user]).and_return(result)
      post :create, params
    end

    describe 'on success' do

      it 'redirects to index' do
        post :create, params
        expect(response).to redirect_to(users_path)
      end
    end

    describe 'one failure' do

      before :each do
        user.errors.add(:base, 'message')
      end

      it 'assigns user and renders new' do
        post :create, params
        expect(response).to be_success
        expect(assigns(:user)).to be user
      end
    end
  end

  describe '#show' do

    let(:user) { User.new(id: 786) }

    before :each do
      allow(User).to receive(:find).and_return(user)
    end

    it 'should render show and return http success ' do
      get :show, id: user.to_param
      expect(response).to render_template :show
      expect(response).to be_success
    end

    it 'should run uc ShowUser and assign presenter' do
      expect(User).to receive(:find).with(user.to_param).and_return(user)

      get :show, id: user.to_param
      expect(assigns(:user)).to be user
    end
  end

  describe '#update' do

    let(:user) { create(:user) }
    let(:params) { {id: user.to_param, user: {'email' => 'test@mail.de'}} }
    let(:result) { Users::Create::ResultWithToken.new(user, 'raw_token') }
    let(:referrer) { 'users' }

    before :each do
      allow(@controller.request).to receive(:referrer).and_return(referrer)
      allow(Users::Update).to receive(:run).and_return(user)
    end

    it 'passes correct params to Users::Update' do
      expect(Users::Update).
          to receive(:run).with(current_user: @controller.current_user,
                                user_id: params[:id],
                                user_attributes: params[:user]).and_return(user)

      patch :update, params
    end

    describe 'on success' do

      it 'redirects to users_path and set flash message' do
        patch :update, params

        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq I18n.t('model.messages.updated', model: User.model_name.human)
      end

      describe 'if referrer contains /user_tips' do

        let(:referrer) { '/user_tips/33' }

        it 'it redirects to referrer path' do
          patch :update, params
          expect(response).to redirect_to URI(request.referrer).path
        end
      end
    end

    describe 'on failure' do

      before :each do
        user.errors.add :base, 'message'
      end

      it 'assigns user and renders edit' do
        patch :update, params

        expect(assigns(:user)).to be user
        expect(response).to be_success
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do

    let(:user) { create(:user) }

    before :each do
      allow(Users::Delete).to receive(:run).and_return(user)
    end

    it 'should run uc Users::Delete' do
      expect(Users::Delete).to receive(:run).and_return(user)
      delete :destroy, id: user.to_param
    end

    it 'should redirect to users_path and assign flash messge' do
      delete :destroy, id: user.to_param
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: user.nickname)
    end
  end

end
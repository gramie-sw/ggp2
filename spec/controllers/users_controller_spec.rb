describe UsersController do

  before :each do
    create_and_sign_in :admin
  end

  describe '#show' do

    let(:user) { create(:user) }

    before :each do
      allow_any_instance_of(ShowUser).to receive(:run_with_presentable)
    end

    it 'should render show and return http success ' do
      get :show, id: user.to_param
      expect(response).to render_template :show
      expect(response).to be_success
    end

    it 'should run uc ShowUser and assign presenter' do
      expect(ShowUser).to receive(:new).with(user.to_param).and_call_original
      expect_any_instance_of(ShowUser).to receive(:run_with_presentable).with(instance_of(UserShowPresenter))

      get :show, id: user.to_param

      expect(assigns(:presenter)).to be_instance_of UserShowPresenter
    end

  end

  describe '#destroy' do

    let(:user) { create(:user) }

    before :each do
      allow_any_instance_of(DeleteUser).to receive(:run).and_return(user)
    end

    it 'should redirect to users_path and assign flash messgae' do
      delete :destroy, id: user.to_param
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: user.nickname)
    end

    it 'should run uc DeleteUser' do
      delete :destroy, id: user.to_param
    end
  end

end
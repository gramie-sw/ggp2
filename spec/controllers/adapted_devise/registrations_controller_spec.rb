describe AdaptedDevise::RegistrationsController do

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
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

    it 'should assign @user' do
      get :new
      assigns(:user).should be_a_new User
    end
  end

  describe '#create' do

    let(:params) { {user: {'email' => 'test@mail.de'}}}
    let(:user) { create(:player)}
    let(:result) {CreateUser::ResultWithToken.new(user, true, 'raw_token') }

    before :each do
      CreateUser.any_instance.stub(:run).with(params[:user]).and_return(result)
    end

    context 'on success' do

      it 'should redirect to new_user_session_path' do
        post :create, params
        response.should redirect_to(new_user_session_path)
      end

      it 'should assign notice message' do
        post :create, params
        flash[:notice].should eq t('devise.passwords.send_initial_instructions')
      end

      it 'should send email for intitial password reset instructions' do
        message = double('Message')
        UserMailer.should_receive(:user_signed_up).with do |user, raw_token|
          user.should eq result.user
          raw_token.should eq result.raw_token
        end.and_return(message)
        message.should_receive(:deliver)
        post :create, params
      end
    end

    context 'on failure' do

      let(:result) {CreateUser::ResultWithToken.new(user, false, nil) }

      it 'should return success' do
        post :create, params
        response.should be_success
      end

      it 'should render new' do
        post :create, params
        response.should render_template :new
      end

      it'should assign user with correct arguments' do
        post :create, params
        assigns(:user).should be_a(User)
        assigns(:user).should be result.user
      end
    end
  end
end
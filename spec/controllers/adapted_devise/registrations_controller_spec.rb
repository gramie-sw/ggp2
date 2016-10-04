describe AdaptedDevise::RegistrationsController, :type => :controller do

  let(:user) { create(:player) }
  let(:admin) { create(:admin) }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end


  describe '#create' do

    let(:params) { {user: {'email' => 'test@mail.de'}} }
    let(:result) { Users::Create::ResultWithToken.new(user, 'raw_token') }

    describe 'if captcha is verified' do

      before :each do
        allow(Users::Create).to receive(:run).and_return(result)
        expect(@controller).to respond_to(:verify_recaptcha)
        expect(@controller).to receive(:verify_recaptcha).and_return(true)
      end

      it 'passes correct params to User::Create' do
        expect(Users::Create).to receive(:run).
            with(user_attributes: ActionController::Parameters.new(params[:user]).permit!).
            and_return(result)
        post :create, params: params
      end

      context 'on success' do

        it 'redirects to new_user_session_path and assign notice message' do
          post :create, params: params
          expect(response).to redirect_to(new_user_session_path)
          expect(flash[:notice]).to eq t('devise.passwords.send_initial_instructions')
        end

        it 'should send email for intitial password reset instructions' do
          message = double('Message')
          expect(UserMailer).to receive(:user_signed_up) do |user, raw_token|
            expect(user).to eq result.user
            expect(raw_token).to eq result.raw_token
          end.and_return(message)
          expect(message).to receive(:deliver_now)
          post :create, params: params
        end
      end

      context 'on failure' do

        before :each do
          user.errors.add(:base, 'message')
        end

        it 'renders new' do
          post :create, params: params
          expect(response).to be_success
          expect(response).to render_template :new
        end

        it 'should assign user with correct arguments' do
          post :create, params: params
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be result.user
        end
      end
    end

    describe 'if captcha is not verified' do

      before :each do
        expect(@controller).to respond_to(:verify_recaptcha)
        expect(@controller).to receive(:verify_recaptcha).and_return(false)
      end

      it 'renders new' do
        post :create, params: params
        expect(response).to be_success
        expect(response).to render_template :new
      end

      it 'assigns user with given attributes and captcha error massage and renders new' do
        expect(User).to receive(:new).
            with(ActionController::Parameters.new(params[:user]).permit!).and_return(user)
        post :create, params: params
        expect(assigns(:user)).to be user
        expect(assigns(:user).errors[:base]).to include I18n.t('recaptcha.wrong_input')
      end
    end
  end

  describe '#after_update_path' do

    it 'returns edit_user_registration_path if current user is admin' do
      expect(subject.after_update_path_for(admin)).to eq edit_user_registration_path
    end

    it 'returns profile_path if current user is not an admin' do
      expect(subject.after_update_path_for(user)).to eq profile_path(user, section: :user_data)
    end
  end
end

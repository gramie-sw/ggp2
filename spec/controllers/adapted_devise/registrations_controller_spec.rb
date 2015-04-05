describe AdaptedDevise::RegistrationsController, :type => :controller do

  let(:user) { create(:player) }
  let(:admin) { create(:admin) }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe '#create' do

    let(:params) { {user: {'email' => 'test@mail.de'}} }
    let(:result) { CreateUser::ResultWithToken.new(user, true, 'raw_token') }

    before :each do
      allow_any_instance_of(CreateUser).to receive(:run).with(params[:user]).and_return(result)
    end

    context 'on success' do

      it 'should redirect to new_user_session_path' do
        post :create, params
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'should assign notice message' do
        post :create, params
        expect(flash[:notice]).to eq t('devise.passwords.send_initial_instructions')
      end

      it 'should send email for intitial password reset instructions' do
        message = double('Message')
        expect(UserMailer).to receive(:user_signed_up) do |user, raw_token|
          expect(user).to eq result.user
          expect(raw_token).to eq result.raw_token
        end.and_return(message)
        expect(message).to receive(:deliver_now)
        post :create, params
      end
    end

    context 'on failure' do

      let(:result) { CreateUser::ResultWithToken.new(user, false, nil) }

      it 'should return success' do
        post :create, params
        expect(response).to be_success
      end

      it 'should render new' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'should assign user with correct arguments' do
        post :create, params
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be result.user
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
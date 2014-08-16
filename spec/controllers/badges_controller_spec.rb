describe BadgesController, :type => :controller do

  let(:current_user) { create(:player) }

  before :each do
    sign_in current_user
  end

  describe '#show' do

    it 'should return http success' do
      get :show
      expect(response).to be_success
    end

    it 'should render template show' do
      get :show
      expect(response).to render_template :show
    end

    it 'should run uc FindBadges and assign presenter' do

      get :show
      expect(assigns(:presenter)).to be_an_instance_of(BadgesShowPresenter)
    end
  end
end
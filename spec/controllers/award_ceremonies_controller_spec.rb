describe AwardCeremoniesController, :type => :controller do

  let(:current_user) { create(:player) }

  before :each do
    sign_in current_user
  end

  describe '#show' do

    before :each do
      allow_any_instance_of(Rankings::FindWinners).to receive(:run)
    end

    it 'should return http success' do
      get :show
      expect(response).to be_success
    end

    it 'should render template show' do
      get :show
      expect(response).to render_template :show
    end
  end
end
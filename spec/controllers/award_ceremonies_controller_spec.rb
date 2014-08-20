describe AwardCeremoniesController, :type => :controller do

  let(:current_user) { create(:player) }

  before :each do
    sign_in current_user
  end

  describe '#show' do

    before :each do
      allow_any_instance_of(FindWinnerRanking).to receive(:run)
    end

    it 'should return http success' do
      get :show
      expect(response).to be_success
    end

    it 'should render template show' do
      get :show
      expect(response).to render_template :show
    end

    it 'should run uc ShowWinnerRanking and assign presenter' do
      expected_presenter = AwardCeremoniesShowPresenter.new nil
      expect(AwardCeremoniesShowPresenter).to receive(:new).with(@controller.tournament).and_return(expected_presenter)
      expect_any_instance_of(FindWinnerRanking).to receive(:run).with(expected_presenter)

      get :show

      expect(assigns(:presenter)).to eq expected_presenter
    end

  end
end
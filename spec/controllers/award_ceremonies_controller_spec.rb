describe AwardCeremoniesController do

  let(:current_user) { create(:player) }

  before :each do
    sign_in current_user
  end

  describe '#show' do

    before :each do
      ShowWinnerRanking.any_instance.stub(:run)
    end

    it 'should return http success' do
      get :show
      response.should be_success
    end

    it 'should render template show' do
      get :show
      response.should render_template :show
    end

    it 'should run uc ShowWinnerRanking and assign presenter' do
      expected_presenter = AwardCeremoniesShowPresenter.new
      AwardCeremoniesShowPresenter.should_receive(:new).and_return(expected_presenter)
      ShowWinnerRanking.any_instance.should_receive(:run).with(expected_presenter)

      get :show

      assigns(:presenter).should eq expected_presenter
    end

  end
end
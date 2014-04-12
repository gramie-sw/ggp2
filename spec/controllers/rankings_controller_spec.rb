describe RankingsController do

  let(:current_user) { create(:player) }

  before :each do
    sign_in current_user
  end

  describe '#show' do

    before :each do
      ShowAllUserCurrentRanking.any_instance.stub(:run)
    end

    it 'should return http success' do
      get :show
      response.should be_success
    end

    it 'should render template show' do
      get :show
      response.should render_template :show
    end

    it 'should run uc ShowAllUserCurrentRanking and render show' do
      expected_presenter = double('RankingShowPresenter')
      show_all_user_current_ranking = ShowAllUserCurrentRanking.new
      page = '2'

      RankingsShowPresenter.should_receive(:new).
          with(tournament: @controller.tournament,
               current_user_id: current_user.id,
               page: page).
          and_return(expected_presenter)
      ShowAllUserCurrentRanking.should_receive(:new).with(no_args).and_return(show_all_user_current_ranking)
      show_all_user_current_ranking.should_receive(:run).with(expected_presenter, page)

      get :show, page: page

      assigns(:presenter).should be expected_presenter
    end
  end

end

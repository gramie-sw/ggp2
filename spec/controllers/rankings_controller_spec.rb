describe RankingsController, :type => :controller do

  let(:current_user) { create(:player) }

  before :each do
    sign_in current_user
  end

  describe '#show' do

    before :each do
      allow_any_instance_of(ShowAllUserCurrentRanking).to receive(:run)
    end

    it 'should return http success' do
      get :show
      expect(response).to be_success
    end

    it 'should render template show' do
      get :show
      expect(response).to render_template :show
    end

    it 'should run uc ShowAllUserCurrentRanking and render show' do
      expected_presenter = double('RankingShowPresenter')
      show_all_user_current_ranking = ShowAllUserCurrentRanking.new
      page = '2'

      expect(RankingsShowPresenter).to receive(:new).
          with(tournament: @controller.tournament,
               current_user_id: current_user.id,
               page: page).
          and_return(expected_presenter)
      expect(ShowAllUserCurrentRanking).to receive(:new).with(no_args).and_return(show_all_user_current_ranking)
      expect(show_all_user_current_ranking).to receive(:run).with(expected_presenter, page)

      get :show, page: page

      expect(assigns(:presenter)).to be expected_presenter
    end
  end

end

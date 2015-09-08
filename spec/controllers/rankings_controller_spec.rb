describe RankingsController, :type => :controller do

  let(:current_user) { create(:player) }

  before :each do
    sign_in current_user
  end

  describe '#show' do

    before :each do
      allow(Rankings::FindCurrentForAllUsers).to receive(:run)
    end


    it 'calls Rankings::FindCurrentForAllUsers and assigns RankingShowPresenter' do
      page = '2'
      expect(Rankings::FindCurrentForAllUsers).to receive(:run).with(page: page).and_return(:ranking_items)
      expect(RankingPresenter).to receive(:new).with(
                                           ranking_items: :ranking_items,
                                           tournament: @controller.tournament,
                                           current_user_id: current_user.id
                                       ).and_return(:presenter)

      get :show, page: page
      expect(assigns(:presenter)).to be :presenter
    end

    it 'should return http success and render template show' do
      get :show
      expect(response).to be_success
      expect(response).to render_template :show
    end
  end
end

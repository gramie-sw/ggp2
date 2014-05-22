describe UserTipsController do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#show' do

    before :each do
      allow_any_instance_of(ShowAllTipsOfAggregateForUser).to receive(:run_with_presentable)
      allow_any_instance_of(ShowChampionTip).to receive(:run_with_presentable)
      allow_any_instance_of(ShowAllPhases).to receive(:run_with_presentable)
    end

    it 'should return http success render template show' do
      get :show, id: player.to_param
      response.should be_success
      response.should render_template :show
    end

    it 'should assign UserTipsShowPresenter' do
      expect(UserTipsShowPresenter).to receive(:new).with(
                                           user: instance_of(User),
                                           tournament: instance_of(Tournament),
                                           user_is_current_user: true
                                       ).and_call_original
      get :show, id: player.to_param, aggregate_id: 5
      expect(assigns(:presenter)).to be_instance_of(UserTipsShowPresenter)
    end
  end
end

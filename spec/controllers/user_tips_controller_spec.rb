describe UserTipsController, :type => :controller do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#show' do

    let(:aggregate) { Aggregate.new(id: 1234) }
    let(:params) { {id: player.id, aggregate_id: aggregate.to_param} }

    before :each do
      allow(Aggregates::FindOrFindCurrentPhase).to receive(:run).and_return(aggregate)
    end

    it 'passes correct params to Aggregates::FindOrFindCurrentPhase' do
      expect(Aggregates::FindOrFindCurrentPhase).to receive(:run).with(id: aggregate.to_param).and_return(aggregate)
      get :show, params: params
    end

    it 'assigns UserTipsPresenter and renders template show' do
      expect(@controller).to receive(:is_user_current_user?).with(player).and_return(:is_is_current_user)
      expect(UserTipsPresenter).to receive(:new).with(
                                       user: player,
                                       current_aggregate: aggregate,
                                       tournament: @controller.tournament,
                                       user_is_current_user: :is_is_current_user
                                   ).and_return(:presenter)
      get :show, params: params

      expect(assigns(:presenter)).to be :presenter
      expect(response).to render_template :show
    end

    it 'stores aggregate_id in session' do
      get :show, params: params
      expect(@controller.session[Ggp2::USER_TIPS_LAST_SHOWN_AGGREGATE_ID_KEY]).to eq aggregate.to_param
    end

  end
end

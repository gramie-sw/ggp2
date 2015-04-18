describe MatchSchedulesController do

  before :each do
    create_and_sign_in :admin
  end

  describe '#show' do

    let(:aggregate) { Aggregate.new(id: 67) }
    let(:params) { {'aggregate_id' => aggregate.to_param} }

    before :each do
      allow(Aggregates::FindOrFindCurrentPhase).to receive(:run).and_return(aggregate)
    end

    it 'passed correct params to Aggregates::FindOrFindCurrentPhase' do
      expect(Aggregates::FindOrFindCurrentPhase).to receive(:run).with(id: aggregate.to_param).and_return(aggregate)
      get :show, params
    end

    it 'assigns MatchSchedulePresenter and renders show' do
      expect(MatchSchedulePresenter).to receive(:new).with(current_aggregate: aggregate).and_call_original

      get :show, params
      expect(assigns(:presenter)).to be_instance_of MatchSchedulePresenter
      expect(response).to render_template :show
    end
  end
end
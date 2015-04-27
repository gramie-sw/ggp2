describe AggregatesController, :type => :controller do

  before :each do
    create_and_sign_in :admin
  end

  describe '#new' do

    let(:new_aggregate) { Aggregate.new }

    before :each do
      allow(Aggregate).to receive(:new).and_return(new_aggregate)
    end

    it 'should assign AggregateFormPresenter with new Aggregate with set parent_id' do
      phase_id = '343'
      expect(Aggregate).to receive(:new).with(parent_id: phase_id).and_return(new_aggregate)
      expect(AggregateFormPresenter).to receive(:new).with(new_aggregate).and_return(:presenter)
      get :new, phase_id: phase_id

      expect(assigns(:presenter)).to be (:presenter)
    end

    it 'should render template new' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe '#create' do

    let(:created_aggregate) { Aggregate.new(id: 4566, name: 'A1') }
    let(:params) { {aggregate: {'aggregates_key' => 'aggregates_value'}} }

    before :each do
      allow(Aggregate).to receive(:create).and_return(created_aggregate)
    end

    context 'if successful' do

      it 'creates aggregate with values from params' do
        expect(Aggregate).to receive(:create).with(params[:aggregate]).and_return(created_aggregate)
        post :create, params
      end

      let(:notice_message) { t('model.messages.created', model: created_aggregate.message_name) }

      context 'if subsequent_aggregate is not present' do

        it 'redirects to new_aggregate_path and assigns notice message' do
          post :create, params
          expect(response).to redirect_to match_schedules_path(aggregate_id: created_aggregate.id)
          expect(flash[:notice]).to eq notice_message
        end
      end

      context 'if subsequent_aggregate is present in params' do

        it 'redirects to new_aggregate_path and assigns notice message' do
          allow(created_aggregate).to receive(:parent_id).and_return(333)
          params[:subsequent_aggregate] = '1'

          post :create, params
          expect(response).to redirect_to new_aggregate_path(phase_id: created_aggregate.parent_id)
          expect(flash[:notice]).to eq notice_message
        end
      end
    end

    context 'if failing' do

      before :each do
        created_aggregate.errors.add(:base, 'error')
      end

      it 'assigns AggregateFormPresenter and render new' do
        expect(AggregateFormPresenter).to receive(:new).with(created_aggregate).and_return(:presenter)
        post :create, params
        expect(assigns(:presenter)).to be :presenter
        expect(response).to render_template :new
      end
    end
  end

  describe '#edit' do

    let(:aggregate) { Aggregate.new(id: 232) }

    before :each do
      allow(Aggregate).to receive(:find).and_return(aggregate)
    end

    it 'assigns AggregateFormPresenter with requested Aggregate' do
      expect(Aggregate).to receive(:find).with(aggregate.to_param).and_return(aggregate)
      expect(AggregateFormPresenter).to receive(:new).with(aggregate).and_return(:presenter)

      get :edit, id: aggregate.to_param
      expect(assigns(:presenter)).to be :presenter
    end

    it 'should render template edit' do
      get :edit, id: aggregate.to_param
      expect(response).to render_template :edit
    end
  end

  describe '#update' do

    let(:aggregate) { Aggregate.new(id: 3435, name: 'A2') }
    let(:params) { {id: aggregate.to_param, aggregate: {'aggregate_key' => 'aggregate_value'}} }

    before :each do
      allow(Aggregate).to receive(:find).and_return(aggregate)
    end

    context 'if successful' do

      before :each do
        allow(aggregate).to receive(:update_attributes).and_return(true)
      end

      it 'should update aggregate with given params' do
        expect(Aggregate).to receive(:find).with(aggregate.to_param).and_return(aggregate)
        expect(aggregate).to receive(:update_attributes).with(params[:aggregate]).and_return(true)

        patch :update, params
      end

      it 'should redirect to match_schedules_path and assign notice message' do
        parent_id = 222
        expect(aggregate).to receive(:parent_id).and_return(parent_id)
        patch :update, params
        expect(response).to redirect_to match_schedules_path(aggregate_id: parent_id)
        expect(flash[:notice]).to eq t('model.messages.updated', model: aggregate.message_name)
      end
    end

    context 'if failing' do

      before :each do
        allow(aggregate).to receive(:update_attributes).and_return(false)
      end

      it 'should assign AggregateFormPresenter and render edit' do
        expect(AggregateFormPresenter).to receive(:new).with(aggregate).and_return(:presenter)
        patch :update, params
        expect(assigns(:presenter)).to eq :presenter
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do

    let(:aggregate) { Aggregate.new(id: 334) }

    before :each do
      allow(Aggregate).to receive(:find).and_return(aggregate)
    end

    it 'should destroy aggregate' do
      expect(aggregate).to receive(:destroy)
      delete :destroy, id: aggregate.to_param
    end

    it 'should redirect to match_schedule_path and assing_notice' do
      parent_id = 222
      expect(aggregate).to receive(:parent_id).and_return(parent_id)
      delete :destroy, id: aggregate.to_param
      expect(response).to redirect_to match_schedules_path(aggregate_id: parent_id)
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: aggregate.message_name)
    end
  end
end
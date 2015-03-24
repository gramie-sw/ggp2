describe AggregatesController, :type => :controller do

  before :each do
    create_and_sign_in :admin
  end

  describe '#index' do
    it 'should return http success' do
      get :index
      expect(response).to be_success
    end

    it 'should render template index' do
      get :index
      expect(response).to render_template :index
    end

    it 'should assign @aggregates' do
      aggregate = create(:aggregate)

      get :index
      expect(assigns(:aggregates)).to eq [aggregate]
    end
  end

  describe '#new' do
    it 'should return http success' do
      get :new
      expect(response).to be_success
    end

    it 'should render template new' do
      get :new
      expect(response).to render_template :new
    end

    it 'should assign @aggregate' do
      get :new
      expect(assigns(:aggregate)).to be_a_new(Aggregate)
    end
  end

  describe '#create' do

    let(:params) { {aggregate: {position: 1, name: 'TestAggregate'}} }

    context 'if successful' do
      it 'should redirect to index' do
        post :create, params
        expect(response).to redirect_to aggregates_path
      end

      it 'should create aggregate with values from params' do
        post :create, params
        expect(assigns(:aggregate)).not_to be_a_new Aggregate
        expect(assigns(:aggregate).position).to eq 1
        expect(assigns(:aggregate).name).to eq 'TestAggregate'
      end

      it 'should assign notice flash message' do
        post :create, params
        expect(flash[:notice]).to eq t('model.messages.created', model: assigns(:aggregate).message_name)
      end
    end

    context 'if failing' do

      before :each do
        allow_any_instance_of(Aggregate).to receive(:valid?).and_return(false)
      end

      it 'should render new' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'should assign existing @aggregate' do
        post :create, params
        expect(assigns(:aggregate)).to be_a_new Aggregate
        expect(assigns(:aggregate).position).to eq 1
        expect(assigns(:aggregate).name).to eq 'TestAggregate'
      end
    end
  end

  describe '#edit' do

    let(:aggregate) { create(:aggregate) }

    it 'should return http success' do
      get :edit, id: aggregate.to_param
      expect(response).to be_success
    end

    it 'should render template edit' do
      get :edit, id: aggregate.to_param
      expect(response).to render_template :edit
    end

    it 'should assign @aggregate' do
      get :edit, id: aggregate.to_param
      expect(assigns(:aggregate)).to eq aggregate
    end
  end

  describe '#update' do

    let(:aggregate) { create(:aggregate) }

    context 'if successful' do

      let(:params) { {id: aggregate.to_param, aggregate: {name: 'Updated Name'}} }

      it 'should redirect to index' do
        patch :update, params
        expect(response).to redirect_to aggregates_path
      end

      it 'should update aggregate with given params' do
        patch :update, params
        expect(assigns(:aggregate).name).to eq 'Updated Name'
      end

      it 'should assign notice flash message' do
        patch :update, params
        expect(flash[:notice]).to eq t('model.messages.updated', model: assigns(:aggregate).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {id: aggregate.to_param, aggregate: {name: ''}} }

      it 'should render edit' do
        patch :update, params
        expect(response).to render_template :edit
      end

      it 'should assign existing @aggregate with no changes' do
        patch :update, params
        expect(assigns(:aggregate)).to eq aggregate
      end
    end
  end

  describe '#destroy' do

    let(:aggregate) { create(:aggregate) }

    it 'should redirect to index' do
      delete :destroy, id: aggregate.to_param
      expect(response).to redirect_to aggregates_path
    end

    it 'should destroy aggregate' do
      delete :destroy, id: aggregate.to_param
      expect(Aggregate.exists?(aggregate.id)).to be_falsey
    end

    it 'should assign notice flash message' do
      delete :destroy, id: aggregate.to_param
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: aggregate.message_name)
    end
  end
end
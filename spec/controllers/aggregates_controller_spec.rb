describe AggregatesController do

  let(:admin) { create(:admin) }

  before :each do
    sign_in admin
  end

  describe '#index' do
    it 'should return http success' do
      get :index
      response.should be_success
    end

    it 'should render template index' do
      get :index
      response.should render_template :index
    end

    it 'should assign @aggregates' do
      aggregate = create(:aggregate)

      get :index
      assigns(:aggregates).should eq [aggregate]
    end
  end

  describe '#new' do
    it 'should return http success' do
      get :new
      response.should be_success
    end

    it 'should render template new' do
      get :new
      response.should render_template :new
    end

    it 'should assign @aggregate' do
      get :new
      assigns(:aggregate).should be_a_new(Aggregate)
    end
  end

  describe '#create' do

    let(:params) { {aggregate: {position: 1, name: 'TestAggregate'}} }

    context 'if successful' do
      it 'should redirect to index' do
        post :create, params
        response.should redirect_to aggregates_path
      end

      it 'should create aggregate with values from params' do
        post :create, params
        assigns(:aggregate).should_not be_a_new Aggregate
        assigns(:aggregate).position.should eq 1
        assigns(:aggregate).name.should eq 'TestAggregate'
      end

      it 'should assign notice flash message' do
        post :create, params
        flash[:notice].should eq t('model.messages.created', model: assigns(:aggregate).message_name)
      end
    end

    context 'if failing' do

      before :each do
        Aggregate.any_instance.stub(:valid?).and_return(false)
      end

      it 'should render new' do
        post :create, params
        response.should render_template :new
      end

      it 'should assign existing @aggregate' do
        post :create, params
        assigns(:aggregate).should be_a_new Aggregate
        assigns(:aggregate).position.should eq 1
        assigns(:aggregate).name.should eq 'TestAggregate'
      end
    end
  end

  describe '#edit' do

    let(:aggregate) { create(:aggregate) }

    it 'should return http success' do
      get :edit, id: aggregate.to_param
      response.should be_success
    end

    it 'should render template edit' do
      get :edit, id: aggregate.to_param
      response.should render_template :edit
    end

    it 'should assign @aggregate' do
      get :edit, id: aggregate.to_param
      assigns(:aggregate).should eq aggregate
    end
  end

  describe '#update' do

    let(:aggregate) { create(:aggregate) }

    context 'if successful' do

      let(:params) { {id: aggregate.to_param, aggregate: {name: 'Updated Name'}} }

      it 'should redirect to index' do
        patch :update, params
        response.should redirect_to aggregates_path
      end

      it 'should update aggregate with given params' do
        patch :update, params
        assigns(:aggregate).name.should eq 'Updated Name'
      end

      it 'should assign notice flash message' do
        patch :update, params
        flash[:notice].should eq t('model.messages.updated', model: assigns(:aggregate).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {id: aggregate.to_param, aggregate: {name: ''}} }

      it 'should render edit' do
        patch :update, params
        response.should render_template :edit
      end

      it 'should assign existing @aggregate with no changes' do
        patch :update, params
        assigns(:aggregate).should eq aggregate
      end
    end
  end

  describe '#destroy' do

    let(:aggregate) { create(:aggregate) }

    it 'should redirect to index' do
      delete :destroy, id: aggregate.to_param
      response.should redirect_to aggregates_path
    end

    it 'should delete aggregate' do
      delete :destroy, id: aggregate.to_param
      Aggregate.exists?(aggregate.id).should be_false
    end

    it 'should assign notice flash message' do
      delete :destroy, id: aggregate.to_param
      flash[:notice].should eq t('model.messages.destroyed', model: aggregate.message_name)
    end
  end
end
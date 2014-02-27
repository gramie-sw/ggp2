describe VenuesController do

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

    it 'should assign @venues' do
      venue = create(:venue)

      get :index
      assigns(:venues).should eq [venue]
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

    it 'should assign @venue' do
      get :new
      assigns(:venue).should be_a_new(Venue)
    end
  end

  describe '#create' do

    let(:params) { {venue: {city: 'Dortmund', stadium: 'Signal Iduna Park', capacity: 80700}} }

    context 'if successful' do
      it 'should redirect to index' do
        post :create, params
        response.should redirect_to venues_path
      end

      it 'should create venue with values from params' do
        post :create, params
        assigns(:venue).should_not be_a_new(Venue)
        assigns(:venue).city.should eq 'Dortmund'
        assigns(:venue).stadium.should eq 'Signal Iduna Park'
        assigns(:venue).capacity.should eq 80700
      end

      it 'should assign notice flash message' do
        post :create, params
        flash[:notice].should eq t('model.messages.created', model: assigns(:venue).message_name)
      end
    end

    context 'if failing' do

      before :each do
        Venue.any_instance.stub(:valid?).and_return(false)
      end

      it 'should render new' do
        post :create, params
        response.should render_template :new
      end

      it 'should assign existing @venue' do
        post :create, params
        assigns(:venue).should be_a_new Venue
        assigns(:venue).city.should eq 'Dortmund'
        assigns(:venue).stadium.should eq 'Signal Iduna Park'
        assigns(:venue).capacity.should eq 80700
      end
    end
  end

  describe '#edit' do

    let(:venue) { create(:venue) }

    it 'should return http success' do
      get :edit, id: venue.to_param
      response.should be_success
    end

    it 'should render template edit' do
      get :edit, id: venue.to_param
      response.should render_template :edit
    end

    it 'should assign @venue' do
      get :edit, id: venue.to_param
      assigns(:venue).should eq venue
    end
  end

  describe '#update' do

    let(:venue) { create(:venue) }

    context 'if successful' do

      let(:params) { {id: venue.to_param, venue: {capacity: 91500}} }

      it 'should redirect to index' do
        patch :update, params
        response.should redirect_to venues_path
      end

      it 'should update venue with given params' do
        patch :update, params
        assigns(:venue).capacity.should eq 91500
      end

      it 'should assign notice flash message' do
        patch :update, params
        flash[:notice].should eq t('model.messages.updated', model: assigns(:venue).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {id: venue.to_param, venue: {stadium: ''}} }

      it 'should render edit' do
        patch :update, params
        response.should render_template :edit
      end

      it 'should assign existing venue with no changes' do
        patch :update, params
        assigns(:venue).should eq venue
      end
    end
  end

  describe '#destroy' do

    let(:venue) { create(:venue) }

    it 'should redirect to index' do
      delete :destroy, id: venue.to_param
      response.should redirect_to venues_path
    end

    it 'should delete venue' do
      delete :destroy, id: venue.to_param
      Venue.exists?(venue.id).should be_false
    end

    it 'should assign notice flash message' do
      delete :destroy, id: venue.to_param
      flash[:notice].should eq t('model.messages.destroyed', model: venue.message_name)
    end
  end
end
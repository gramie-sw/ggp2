describe VenuesController, :type => :controller do

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

    it 'should assign @venues' do
      venue = create(:venue)

      get :index
      expect(assigns(:venues)).to eq [venue]
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

    it 'should assign @venue' do
      get :new
      expect(assigns(:venue)).to be_a_new(Venue)
    end
  end

  describe '#create' do

    let(:params) { {venue: {city: 'Dortmund', stadium: 'Signal Iduna Park', capacity: 80700}} }

    context 'if successful' do
      it 'should redirect to index' do
        post :create, params
        expect(response).to redirect_to venues_path
      end

      it 'should create venue with values from params' do
        post :create, params
        expect(assigns(:venue)).not_to be_a_new(Venue)
        expect(assigns(:venue).city).to eq 'Dortmund'
        expect(assigns(:venue).stadium).to eq 'Signal Iduna Park'
        expect(assigns(:venue).capacity).to eq 80700
      end

      it 'should assign notice flash message' do
        post :create, params
        expect(flash[:notice]).to eq t('model.messages.created', model: assigns(:venue).message_name)
      end
    end

    context 'if failing' do

      before :each do
        allow_any_instance_of(Venue).to receive(:valid?).and_return(false)
      end

      it 'should render new' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'should assign existing @venue' do
        post :create, params
        expect(assigns(:venue)).to be_a_new Venue
        expect(assigns(:venue).city).to eq 'Dortmund'
        expect(assigns(:venue).stadium).to eq 'Signal Iduna Park'
        expect(assigns(:venue).capacity).to eq 80700
      end
    end
  end

  describe '#edit' do

    let(:venue) { create(:venue) }

    it 'should return http success' do
      get :edit, id: venue.to_param
      expect(response).to be_success
    end

    it 'should render template edit' do
      get :edit, id: venue.to_param
      expect(response).to render_template :edit
    end

    it 'should assign @venue' do
      get :edit, id: venue.to_param
      expect(assigns(:venue)).to eq venue
    end
  end

  describe '#update' do

    let(:venue) { create(:venue) }

    context 'if successful' do

      let(:params) { {id: venue.to_param, venue: {capacity: 91500}} }

      it 'should redirect to index' do
        patch :update, params
        expect(response).to redirect_to venues_path
      end

      it 'should update venue with given params' do
        patch :update, params
        expect(assigns(:venue).capacity).to eq 91500
      end

      it 'should assign notice flash message' do
        patch :update, params
        expect(flash[:notice]).to eq t('model.messages.updated', model: assigns(:venue).message_name)
      end
    end

    context 'if failing' do

      let(:params) { {id: venue.to_param, venue: {stadium: ''}} }

      it 'should render edit' do
        patch :update, params
        expect(response).to render_template :edit
      end

      it 'should assign existing venue with no changes' do
        patch :update, params
        expect(assigns(:venue)).to eq venue
      end
    end
  end

  describe '#destroy' do

    let(:venue) { create(:venue) }

    it 'should redirect to index' do
      delete :destroy, id: venue.to_param
      expect(response).to redirect_to venues_path
    end

    it 'should destroy venue' do
      delete :destroy, id: venue.to_param
      expect(Venue.exists?(venue)).to be_falsey
    end

    it 'should assign notice flash message' do
      delete :destroy, id: venue.to_param
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: venue.message_name)
    end
  end
end
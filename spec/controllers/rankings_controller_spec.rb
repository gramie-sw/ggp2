describe RankingsController do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#show' do

    it 'should return http success' do
      get :show
      response.should be_success
    end

    it 'should render template show' do
      get :show
      response.should render_template :show
    end

    it 'should assign correctly instantiated RankingsShowPresenter' do
      RankingsShowPresenter.should_receive(:new).with(no_args).and_call_original
      get :show
      assigns(:presenter).should be_kind_of RankingsShowPresenter
    end
  end

end

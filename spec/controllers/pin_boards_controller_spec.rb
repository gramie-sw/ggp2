describe PinBoardsController do

  let(:user) { create(:user) }

  before :each do
    sign_in user
  end


  describe '#show' do

    it 'should return http success' do
      get :show
      response.should be_success
    end

    it 'should return render template show' do
      get :show
      response.should render_template :show
    end
  end
end
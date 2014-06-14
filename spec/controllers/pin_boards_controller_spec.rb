describe PinBoardsController do

  let(:user) { create(:player) }
  let(:is_admin) { false }

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

    it 'should assign correctly instantiated PinBoardsShowPresenter' do
      page = 2
      PinBoardsShowPresenter.should_receive(:new).with(
          comments_repo: Comment, page: page.to_param, current_user_id: user.id, is_admin: is_admin
      ).and_return(:pin_boards_show_presenter)
      get :show, page: page
      assigns(:presenter).should eq :pin_boards_show_presenter
    end
  end
end
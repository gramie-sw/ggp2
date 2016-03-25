describe PinBoardsController, :type => :controller do

  let(:user) { create(:player) }
  let(:is_admin) { false }

  before :each do
    sign_in user
  end


  describe '#show' do

    it 'should return http success' do
      get :show
      expect(response).to be_success
    end

    it 'should return render template show' do
      get :show
      expect(response).to render_template :show
    end

    it 'should assign correctly instantiated PinBoardsShowPresenter' do
      page = 2
      expect(PinBoardsShowPresenter).to receive(:new).with(
          comments_repo: CommentQueries, page: page.to_param, current_user_id: user.id, is_admin: is_admin
      ).and_return(:pin_boards_show_presenter)
      get :show, page: page
      expect(assigns(:presenter)).to eq :pin_boards_show_presenter
    end
  end
end
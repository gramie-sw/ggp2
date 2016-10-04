describe CommentsController, :type => :controller do

  let(:user) { create(:player) }

  before :each do
    sign_in user
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

    it 'should assign correctly instantiated Comment' do
      expect(Comment).to receive(:new).with(user_id: user.id).and_return(:new_comment)
      get :new
      expect(assigns(:comment)).to eq :new_comment
    end
  end


  describe '#create' do

    describe 'calls Comments::Create and' do

      let(:params) { {comment: {'content' => 'content'}} }
      let(:comment) { Comment.new }

      before :each do
        expect(Comments::Create).to receive(:run).
            with(user_id: user.id,
                 comment_attributes: ActionController::Parameters.new(params[:comment]).permit!).
            and_return(comment)
      end

      describe 'on success' do

        it 'assigns flash message and redirects to pin_boards_path' do
          post :create, params: params

          expect(response).to redirect_to pin_boards_path
          expect(flash[:notice]).to eq t('model.messages.created', model: Comment.model_name.human)
        end
      end

      describe 'on failure' do

        before :each do
          comment.errors.add(:base, 'message')
        end

        it 'assigns comment renders new' do
          post :create, params: params

          expect(response).to be_success
          expect(response).to render_template :new
          expect(assigns(:comment)).to be comment
        end
      end
    end
  end

  describe '#edit' do

    let(:comment) { create(:comment, user: user) }
    let(:params) { {id: comment.to_param} }

    before :each do
      allow(Comment).to receive(:find).and_return(comment)
    end

    it 'should return http success' do
      get :edit, params: params
      expect(response).to be_success
    end

    it 'should render edit' do
      get :edit, params: params
      expect(response).to render_template :edit
    end

    it 'should assign comment of given id' do
      expect(Comment).to receive(:find).with(params[:id]).and_return(comment)
      get :edit, params: params
      expect(assigns(:comment)).to be comment
    end
  end

  describe '#update' do

    describe 'calls Comments::Update and' do

      let(:params) { {id: comment.to_param, comment: {'content' => 'new content'}} }
      let(:comment) { create(:comment, user: user) }

      before :each do
        expect(Comments::Update).to receive(:run).
            with(id: comment.to_param,
                 comment_attributes: ActionController::Parameters.new(params[:comment]).permit!).
            and_return(comment)
      end

      describe 'on success' do

        it 'assigns flash message and redirects to pin_boards_path' do
          patch :update, params: params

          expect(response).to redirect_to pin_boards_path
          expect(flash[:notice]).to eq t('model.messages.updated', model: Comment.model_name.human)
        end
      end

      describe 'on failure' do

        before :each do
          comment.errors.add(:base, 'message')
        end

        it 'assigns comment renders edit' do
          patch :update, params: params

          expect(response).to be_success
          expect(response).to render_template :edit
          expect(assigns(:comment)).to be comment
        end
      end
    end
  end

  describe '#destroy' do

    let(:user) { create(:admin) }
    let(:comment) { create(:comment, user: user) }

    it 'calls Comment::Delete and redirect to pin_board_path' do
      expect(Comments::Delete).to receive(:run).with(id: comment.to_param).and_return(comment)

      delete :destroy, params: {id: comment.id}

      expect(response).to redirect_to(pin_boards_path)
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: Comment.model_name.human)
    end
  end
end
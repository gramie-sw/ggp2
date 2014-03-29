describe CommentsController do

  let(:user) { create(:player) }

  before :each do
    sign_in user
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

    it 'should assign correctly instantiated Comment' do
      Comment.should_receive(:new).with(user_id: user.id).and_return(:new_comment)
      get :new
      assigns(:comment).should eq :new_comment
    end
  end

  describe '#create' do

    let(:params) { {comment: {'user_id' => '4', 'content' => 'content'}} }

    context 'on success' do

      before :each do
        Comment.any_instance.stub(:save).and_return(true)
      end

      it 'should redirect to pin_board_path' do
        post :create, params
        response.should redirect_to pin_boards_path
      end

      it 'should assign comment and save it' do
        comment = double('Comment')
        Comment.should_receive(:new).with(params[:comment]).and_return(comment)
        comment.should_receive(:save).and_return(true)
        post :create, params
        assigns(:comment).should be comment
      end

      it 'should assign flash notice' do
        post :create, params
        flash[:notice].should eq t('model.messages.created', model: Comment.model_name.human)
      end
    end

    context 'on failure' do

      before :each do
        Comment.any_instance.stub(:save).and_return(false)
      end

      it 'should return http success' do
        post :create, params
        response.should be_success
      end

      it 'should render new' do
        post :create, params
        response.should render_template :new
      end

      it 'should assign comment and save it' do
        comment = double('Comment')
        Comment.should_receive(:new).with(params[:comment]).and_return(comment)
        comment.should_receive(:save).and_return(false)
        post :create, params
        assigns(:comment).should be comment
      end
    end
  end

  describe '#edit' do

    let(:params) { {id: '5'} }
    let(:comment) { Comment.new }

    before :each do
      Comment.stub(:find).and_return(comment)
    end

    it 'should return http success' do
      get :edit, params
      response.should be_success
    end

    it 'should render edit' do
      get :edit, params
      response.should render_template :edit
    end

    it 'should assign comment of given id' do
      Comment.should_receive(:find).with(params[:id]).and_return(comment)
      get :edit, params
      assigns(:comment).should be comment
    end
  end

  describe '#update' do

    let(:comment) { Comment.new }
    let(:params) { {id: '5', comment: {'content' => 'new_content', }} }

    before :each do
      Comment.stub(:find).with('5').and_return(comment)
    end

    it 'should use CommentService to update comment' do
      CommentService.should_receive(:new).and_call_original
      CommentService.any_instance.
          should_receive(:update_comment).
          with(comment, params[:comment]).
          and_return(CommentService::UpdateResult.new(comment, true))
      patch :update, params
    end

    describe 'on success' do

      before :each do
        CommentService.any_instance.stub(:update_comment).and_return(CommentService::UpdateResult.new(comment, true))
      end

      it 'should redirect to pin_board_path' do
        patch :update, params
        response.should redirect_to pin_boards_path
      end

      it 'should assign flash notice' do
        patch :update, params
        flash[:notice].should eq t('model.messages.updated', model: Comment.model_name.human)
      end
    end

    describe 'on failure' do

      before :each do
        CommentService.any_instance.stub(:update_comment).and_return(CommentService::UpdateResult.new(comment, false))
      end

      it 'should return http success' do
        patch :update, params
        response.should be_success
      end

      it 'should render template edit' do
        patch :update, params
        response.should render_template :edit
      end

      it 'should assign comment' do
        patch :update, params
        assigns(:comment).should eq comment
      end
    end
  end
end
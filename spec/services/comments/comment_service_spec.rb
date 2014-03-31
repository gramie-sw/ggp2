describe CommentService do

  describe '#update_comment' do

    let(:comment) { Comment.new }
    let(:attributes) { {content: 'net_content', user_id: 5} }

    it 'should update comment with given attributes and edited true' do
      comment.should_receive(:update).with(attributes.merge(edited: true))
      subject.update_comment(comment, attributes)
    end

    context 'on success' do

      before :each do
        comment.stub(:update).and_return(true)
      end

      it 'should return UpdateResult where successful? is true' do
        result = subject.update_comment(comment, attributes)
        result.should be_kind_of CommentService::UpdateResult
        result.should be_successful
        result.comment.should be comment
      end
    end
    context 'on failure' do

      before :each do
        comment.stub(:update).and_return(false)
      end

      it 'should return UpdateResult where successful? is false' do
        result = subject.update_comment(comment, attributes)
        result.should be_kind_of CommentService::UpdateResult
        result.should_not be_successful
        result.comment.should be comment
      end
    end
  end
end
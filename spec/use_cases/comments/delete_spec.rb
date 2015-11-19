describe Comments::Delete do

  subject { Comments::Delete }

  let(:comment) { create(:comment) }

  describe '#run' do

    it 'should delete and return comment with given comment_id' do
      actual_comment = subject.run(id: comment.id)

      expect(actual_comment).to eq comment
      expect(actual_comment).to be_destroyed
    end
  end
end
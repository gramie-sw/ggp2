describe DeleteComment do

  let(:comments) do
    [
        create(:comment),
        create(:comment)
    ]
  end

  let(:comment_to_delete) { comments.first }

  subject { DeleteComment.new(comment_to_delete.id) }

  describe '#run' do

    it 'should delete and return comment with given comment_id' do
      expect(subject.run).to eq comments.first

      expect(Comment.count).to eq 1
      expect(Comment.first).to eq comments.second
    end
  end
end
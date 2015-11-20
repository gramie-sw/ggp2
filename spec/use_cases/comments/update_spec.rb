describe Comments::Update do

  let(:comment) { create(:comment, edited: false) }

  describe '#run' do

    let(:attributes) { {content: "#{comment.content} new"} }

    subject { Comments::Update.new(id: comment.id, comment_attributes: attributes) }

    context 'on success' do

      it 'updates comment and returns it' do
        actual_comment = subject.run

        expect(actual_comment).to eq comment
        expect(actual_comment).not_to be_changed
        expect(actual_comment.content).to eq attributes[:content]
        expect(actual_comment.edited).to be true
      end
    end

    context 'on failure' do

      let(:attributes) { {content: ''} }

      it 'does not update comment and returns it with error' do
        actual_comment = subject.run

        expect(actual_comment).to be_changed
        expect(actual_comment.errors[:content]).to be_present
      end
    end
  end
end
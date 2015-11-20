describe Comments::Create do

  describe '#run' do

    let(:attributes) { {content: "content"} }
    let(:user) { create(:user) }

    subject { Comments::Create.new(user_id: user.id, comment_attributes: attributes) }

    context 'on success' do

      it 'creates comment and returns it' do
        actual_comment = subject.run

        expect(actual_comment).to be_persisted
        expect(actual_comment).not_to be_changed
        expect(actual_comment.content).to eq attributes[:content]
        expect(actual_comment.user_id).to eq user.id
      end
    end

    context 'on failure' do

      let(:attributes) { {content: ''} }

      it 'does not save comment and returns it with error' do
        actual_comment = subject.run

        expect(actual_comment).not_to be_persisted
        expect(actual_comment).to be_changed
        expect(actual_comment.errors[:content]).to be_present
      end
    end
  end
end
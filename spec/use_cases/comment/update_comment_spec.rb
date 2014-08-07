describe UpdateComment do

  let(:user) { create(:user) }
  let(:comment) { create(:comment, user: user) }
  let(:callback) { double('Callback') }

  describe '#run_with_callback' do

    let(:current_user) { user }
    let(:new_attributes) do
      {
          user_id: user.id.to_s,
          content: "#{comment.content}_new"
      }
    end

    subject { UpdateComment.new(current_user: current_user, comment_id: comment.id, attributes: new_attributes) }

    context 'on success' do

      it 'should update comment and call callback#update_succeeded' do

        expect(callback).to receive(:update_succeeded).with(comment)
        subject.run_with_callback(callback)
        comment.reload
        expect(comment.content).to eq new_attributes[:content]
        expect(comment.edited).to be_truthy
      end
    end

    context 'on failure' do

      let(:new_attributes) do
        {
            user_id: user.id.to_s,
            content: ''
        }
      end

      it 'should not update comment and call callback#update_failed' do

        expected_comment = comment
        expect(callback).to receive(:update_failed).with(comment)
        subject.run_with_callback(callback)
        comment.reload
        expect(comment).to eq expected_comment
      end
    end

    context 'when current_user does not belong to comment' do

      let(:comment) { create(:comment, user: create(:user)) }

      it 'should raise Ggp2::AuthorizationFailedError' do
        expect { subject.run_with_callback(callback) }.to raise_error Ggp2::AuthorizationFailedError
      end
    end

    context 'when current_user id is different to be updated attribute user_id ' do

      context 'when current user is player' do

        let(:new_attributes) do
          {
              user_id: (user.id+1).to_s,
              content: "#{comment.content}_new"
          }
        end

        it 'should raise Ggp2::AuthorizationFailedError' do
          expect { subject.run_with_callback(callback) }.to raise_error Ggp2::AuthorizationFailedError
        end
      end
    end

    context 'set attribute edited' do

      context 'player' do

        it 'should update with edited true' do

          expect(new_attributes).to receive(:merge).with({edited: true}).and_call_original
          callback.as_null_object
          subject.run_with_callback(callback)
          comment.reload
          expect(comment.edited).to be_truthy
        end
      end
    end
  end
end
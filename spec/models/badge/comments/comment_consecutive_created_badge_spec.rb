describe CommentConsecutiveCreatedBadge do

  subject { CommentConsecutiveCreatedBadge.new(icon: 'icon', color: 'gold', achievement: 2) }

  it { is_expected.to be_a Badge }

  let(:user_ids) {[2,3,4,5]}

  describe '#eligible_user_ids' do

    it 'returns user_ids having at least count consecutive comments' do

      expect(CommentQueries).to receive(:user_ids_ordered_by_creation_desc).and_return([2, 3, 4, 5, 4, 4, 4, 5, 5, 3, 4, 4, 2])

      actual_user_ids = subject.eligible_user_ids user_ids
      expect(actual_user_ids).to eq [4, 5]
    end

    context 'when consecutive user_ids are at the beginning of ordered user_ids' do

      it 'returns user_ids having at least count consecutive comments' do
        expect(CommentQueries).to receive(:user_ids_ordered_by_creation_desc).and_return([2, 2, 3, 4, 5, 3, 2])

        actual_user_ids = subject.eligible_user_ids user_ids
        expect(actual_user_ids).to eq [2]
      end
    end

    context 'when consecutive user_ids are similar but not equal' do

      it 'returns no user_ids' do
        expect(CommentQueries).to receive(:user_ids_ordered_by_creation_desc).and_return([12, 2, 34, 4, 5, 3, 2])

        actual_user_ids = subject.eligible_user_ids user_ids
        expect(actual_user_ids).to be_empty
      end
    end
  end
end
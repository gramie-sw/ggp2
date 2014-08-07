describe CommentConsecutiveCreatedBadge do

  subject { CommentConsecutiveCreatedBadge.new(count: 2, position: 1, icon: 'icon', icon_color: 'icon_color', identifier: 'identifier') }

  it { is_expected.to respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.count).to eq 2
      expect(subject.position).to eq 1
      expect(subject.icon).to eq 'icon'
      expect(subject.icon_color).to eq 'icon_color'
      expect(subject.identifier).to eq 'identifier'
    end
  end

  describe '#eligible_user_ids' do

    it 'should return user_ids having at least count consecutive comments' do

      expect(Comment).to receive(:user_ids_ordered_by_creation_desc).and_return([2, 3, 4, 5, 4, 4, 4, 5, 5, 3, 4, 4, 2])
      expect(Comment).to receive(:user_ids_grouped).and_return([2, 3, 4, 5])

      actual_user_ids = subject.eligible_user_ids
      expect(actual_user_ids).to eq [4, 5]
    end

    context 'when consecutive user_ids are at the beginning of ordered user_ids' do

      it 'should return user_ids having at least count consecutive comments' do
        expect(Comment).to receive(:user_ids_ordered_by_creation_desc).and_return([2, 2, 3, 4, 5, 3, 2])
        expect(Comment).to receive(:user_ids_grouped).and_return([2, 3, 4, 5])

        actual_user_ids = subject.eligible_user_ids
        expect(actual_user_ids).to eq [2]
      end
    end

    context 'when consecutive user_ids are similar but not equal' do

      it 'should return no user_ids' do
        expect(Comment).to receive(:user_ids_ordered_by_creation_desc).and_return([12, 2, 34, 4, 5, 3, 2])
        expect(Comment).to receive(:user_ids_grouped).and_return([2, 3, 4, 5])

        actual_user_ids = subject.eligible_user_ids
        expect(actual_user_ids).to be_empty
      end
    end
  end
end
describe CommentRepository do

  subject { Comment }

  let(:user_ids) {
    [
        create(:user),
        create(:user),
        create(:user),
        create(:user)
    ]
  }


  let!(:comments) {
    [
        create(:comment, user: user_ids[1], created_at: 2.days.ago),
        create(:comment, user: user_ids[1], created_at: 3.days.ago),
        create(:comment, user: user_ids[2], created_at: 4.days.ago),
        create(:comment, user: user_ids[2], created_at: 5.days.ago),
        create(:comment, user: user_ids[2], created_at: 5.minutes.ago),
        create(:comment, user: user_ids[3], created_at: 10.minutes.ago),
        create(:comment, user: user_ids[3], created_at: 15.minutes.ago),
        create(:comment, user: user_ids[0], created_at: 10.days.ago)
    ]
  }


  describe '::group_by_user_with_at_least_comments' do

    it 'returns user_ids grouped comments having user_ids count at least given count' do

      actual_user_ids = subject.group_by_user_with_at_least_comments(2).pluck(:user_id)

      expect(actual_user_ids.size).to eq 3
      expect(actual_user_ids).to include user_ids[1].id, user_ids[2].id, user_ids[3].id
    end
  end

  describe '::user_ids_with_at_least_comments' do

    it 'returns user_ids which have at least given count comments' do

      actual_user_ids = subject.user_ids_with_at_least_comments(user_ids: [user_ids[0], user_ids[1], user_ids[2]],
                                                                count: 2, )

      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include user_ids[1].id, user_ids[2].id
    end
  end

  describe '::user_ids_ordered_by_creation' do

    it 'returns all user ids ordered by creation' do

      actual_user_ids = subject.user_ids_ordered_by_creation_desc

      expect(actual_user_ids.size).to eq 8
      expect(actual_user_ids[0]).to eq comments[4].user_id
      expect(actual_user_ids[1]).to eq comments[5].user_id
      expect(actual_user_ids[2]).to eq comments[6].user_id
      expect(actual_user_ids[3]).to eq comments[0].user_id
      expect(actual_user_ids[4]).to eq comments[1].user_id
      expect(actual_user_ids[5]).to eq comments[2].user_id
      expect(actual_user_ids[6]).to eq comments[3].user_id
      expect(actual_user_ids[7]).to eq comments[7].user_id
    end
  end


  describe '::user_ids_grouped' do

    it 'returns all user ids grouped' do

      actual_user_ids = subject.user_ids_grouped


      expect(actual_user_ids.size).to eq 4
      expect(actual_user_ids).to include user_ids[0].id, user_ids[1].id, user_ids[2].id, user_ids[3].id
    end
  end
end
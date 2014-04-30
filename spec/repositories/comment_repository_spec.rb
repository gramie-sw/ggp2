describe CommentRepository do

  subject { Comment }

  describe '::group_by_user_with_at_least_comments' do

    it 'should return all grouped comments having user_ids count at least given count' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      create(:comment, user: user_2)
      create(:comment, user: user_2)
      create(:comment, user: user_3)
      create(:comment, user: user_3)
      create(:comment, user: user_3)
      create(:comment, user: user_1)

      actual_user_ids = subject.group_by_user_with_at_least_comments(2).pluck(:user_id)

      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids[0]).to eq user_2.id
      expect(actual_user_ids[1]).to eq user_3.id
    end
  end

  describe '::user_ids_with_at_least_comments' do

    it 'should return user_ids which have at least given count comments' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      create(:comment, user: user_2)
      create(:comment, user: user_2)
      create(:comment, user: user_3)
      create(:comment, user: user_3)
      create(:comment, user: user_3)
      create(:comment, user: user_1)

      actual_user_ids = subject.user_ids_with_at_least_comments(2)

      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids[0]).to eq user_2.id
      expect(actual_user_ids[1]).to eq user_3.id
    end
  end

  describe '::user_ids_ordered_by_creation' do

    it 'should return all user ids ordered by creation' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      comment_1 = create(:comment, user: user_2, created_at: 2.days.ago)
      comment_2 = create(:comment, user: user_3, created_at: Time.current)
      comment_3 = create(:comment, user: user_1, created_at: 1.day.ago )

      actual_user_ids = subject.user_ids_ordered_by_creation_desc

      expect(actual_user_ids.size).to eq 3
      expect(actual_user_ids[0]).to eq comment_2.user_id
      expect(actual_user_ids[1]).to eq comment_3.user_id
      expect(actual_user_ids[2]).to eq comment_1.user_id
    end
  end

  describe '::user_ids_grouped' do

    it 'should return all user ids grouped' do

      user_1 = create(:user)
      user_2 = create(:user)

      create(:comment, user: user_1)
      create(:comment, user: user_1)
      create(:comment, user: user_2)

      actual_user_ids = subject.user_ids_grouped

      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include(user_1.id, user_2.id)
    end
  end
end
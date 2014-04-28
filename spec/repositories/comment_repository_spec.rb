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
end
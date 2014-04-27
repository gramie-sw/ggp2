describe CommentRepository do

  subject { Comment }

  describe '::user_ids_with_at_least_comments' do

    it 'should return all comments having user_ids count at least given count' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      create(:comment, user: user_2)
      create(:comment, user: user_2)
      create(:comment, user: user_3)
      create(:comment, user: user_3)
      create(:comment, user: user_3)
      create(:comment, user: user_1)

      user_ids = subject.user_ids_with_at_least_comments(2).pluck(:user_id)

      expect(user_ids.size).to eq 2
      expect(user_ids[0]).to eq user_2.id
      expect(user_ids[1]).to eq user_3.id
    end
  end
end
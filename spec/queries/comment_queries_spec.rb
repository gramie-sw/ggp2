describe CommentQueries do

  let(:users) { (1..4).map { create(:player) } }

  let!(:comments) {
    [
        create(:comment, user: users[1], created_at: 2.days.ago),
        create(:comment, user: users[1], created_at: 3.days.ago),
        create(:comment, user: users[2], created_at: 4.days.ago),
        create(:comment, user: users[2], created_at: 5.days.ago),
        create(:comment, user: users[2], created_at: 5.minutes.ago),
        create(:comment, user: users[3], created_at: 10.minutes.ago),
        create(:comment, user: users[3], created_at: 15.minutes.ago),
        create(:comment, user: users[0], created_at: 10.days.ago)
    ]
  }

  describe '::all_by_user_ids' do

    it 'returns all comments by given user_ids' do
      actual_comments = CommentQueries.all_by_user_ids([users[3].id, users[0].id])

      expect(actual_comments.size).to be 3
      expect(actual_comments).to include comments[5], comments[6], comments[7]
    end
  end

  describe '::group_by_user_with_at_least_comments' do

    it 'returns all user_ids having at least given count' do
      actual_grouped_users = CommentQueries.group_by_user_with_at_least_comments(2)

      expect(actual_grouped_users.size.size).to be 3
      expect(actual_grouped_users.size.keys).to include users[1].id, users[2].id, users[3].id
    end
  end

  describe '::comments_for_pin_board' do

    it 'returns comments relation for pin boards' do
      relation = double('CommentRelation')
      relation.as_null_object

      expect(CommentQueries).to receive(:order_by_created_at_desc).and_return(relation)
      expect(relation).to receive(:includes).with(:user).and_return(relation)
      expect(relation).to receive(:page).with(2).and_return(relation)
      expect(relation).to receive(:per).with(10).and_return(relation)

      expect(CommentQueries.comments_for_pin_board(2)).to eq relation
    end
  end

  describe '::order_by_created_at_desc' do

    it 'returns comments ordered by created at desc' do

      actual_comments = CommentQueries.order_by_created_at_desc

      expect(actual_comments.size).to be 8

      expect(actual_comments[0]).to eq comments[4]
      expect(actual_comments[1]).to eq comments[5]
      expect(actual_comments[2]).to eq comments[6]
      expect(actual_comments[3]).to eq comments[0]
      expect(actual_comments[4]).to eq comments[1]
      expect(actual_comments[5]).to eq comments[2]
      expect(actual_comments[6]).to eq comments[3]
      expect(actual_comments[7]).to eq comments[7]
    end
  end

  describe '::user_ids_grouped' do

    it 'returns user_ids' do
      actual_user_ids = CommentQueries.user_ids_grouped

      expect(actual_user_ids.size).to be 4
      expect(actual_user_ids).to include *users.map(&:id)
    end
  end

  describe '::user_ids_ordered_by_creation_desc' do

    it 'returns user_ids desc' do
      actual_user_ids = CommentQueries.user_ids_ordered_by_creation_desc

      expect(actual_user_ids.size).to be 8
      expect(actual_user_ids[0]).to eq users[2].id
      expect(actual_user_ids[1]).to eq users[3].id
      expect(actual_user_ids[2]).to eq users[3].id
      expect(actual_user_ids[3]).to eq users[1].id
      expect(actual_user_ids[4]).to eq users[1].id
      expect(actual_user_ids[5]).to eq users[2].id
      expect(actual_user_ids[6]).to eq users[2].id
      expect(actual_user_ids[7]).to eq users[0].id
    end
  end

  describe '::user_ids_with_at_least_comments' do

    it 'returns user_ids which have at least given count comments' do

      actual_user_ids = CommentQueries.user_ids_with_at_least_comments(user_ids: [users[0].id, users[1].id, users[2].id],
                                                                       count: 2,)

      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include users[1].id, users[2].id
    end
  end
end
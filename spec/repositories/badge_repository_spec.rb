describe BadgeRepository do

  describe '::find_by_identifiers_sorted' do

    it 'should return all badges by given identifiers sorted' do

      badge_identifiers = ['tip_consecutive_badge_correct_gold', 'comment_consecutive_created_badge_bronze']

      actual_badges = subject.find_by_indentifiers_sorted(badge_identifiers)

      expect(actual_badges.size).to eq 2
      expect(actual_badges.first.identifier).to eq badge_identifiers.second
      expect(actual_badges.second.identifier).to eq badge_identifiers.first
    end
  end

  describe '::identifiers_belong_to_group' do

    it 'should return all identifiers by given group and found in identifiers' do

      badge_identifiers = ['comment_consecutive_created_badge_bronze', 'comment_consecutive_created_badge_bronze',
                           'tip_consecutive_badge_correct_gold']

      actual_identifiers = subject.identifiers_belong_to_group(:comment, badge_identifiers)

      expect(actual_identifiers.size).to eq 1
      expect(actual_identifiers.first).to eq 'comment_consecutive_created_badge_bronze'
    end
  end

  describe '::groups' do

    it 'should return all groups' do

      actual_groups = subject.groups
      expect(actual_groups.size).to eq 2
      expect(actual_groups).to include(:comment, :tip)
    end
  end

  describe '::by_group' do

    it 'should return all badges by group' do

      actual_badges = subject.by_group(:comment)
      expect(actual_badges.size).to eq (2)
      expect(actual_badges.first).to be_an_instance_of(CommentCreatedBadge)
      expect(actual_badges.second).to be_an_instance_of(CommentConsecutiveCreatedBadge)
    end
  end

  describe '::badges_sorted_grouped' do

    it 'expect to return all badges sorted and grouped' do

      expected_badges_sorted_grouped = BadgeRepository.badges_sorted_grouped

      expect(expected_badges_sorted_grouped.keys.size).to eq 2
      expect(expected_badges_sorted_grouped.keys.first).to eq :comment
      expect(expected_badges_sorted_grouped.keys.second).to eq :tip

      expect(expected_badges_sorted_grouped[:comment].size).to eq 2
      expect(expected_badges_sorted_grouped[:comment].first.position).to eq 1
      expect(expected_badges_sorted_grouped[:comment].second.position).to eq 2

      expect(expected_badges_sorted_grouped[:tip].size).to eq 5
      expect(expected_badges_sorted_grouped[:tip][0].position).to eq 3
      expect(expected_badges_sorted_grouped[:tip][1].position).to eq 4
      expect(expected_badges_sorted_grouped[:tip][2].position).to eq 5
      expect(expected_badges_sorted_grouped[:tip][3].position).to eq 6
      expect(expected_badges_sorted_grouped[:tip][4].position).to eq 7
    end

    it 'expect to cache badges sorted grouped' do
      expect(BadgeRepository.badges_sorted_grouped).to eq BadgeRepository.badges_sorted_grouped
    end
  end

  describe '::badges_sorted' do

    it 'expect to return all badges sorted' do

      expected_badges_sorted = BadgeRepository.badges_sorted

      expect(expected_badges_sorted.size).to eq 7

      (1..7).each do |n|
        expect(expected_badges_sorted[(n-1)].position).to eq n
      end
    end
  end
end
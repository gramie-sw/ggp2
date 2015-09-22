describe TipQueries do

  subject { TipQueries }

  describe '#all_eager_by_user_id_and_aggregate_id_ordered' do

    let(:users) { [create(:player), create(:player)] }

    let(:tips) do
      [
          create(:tip, match: matches.first, user: users.first),
          create(:tip, match: matches.first, user: users.second),
          create(:tip, match: matches.second, user: users.first),
          create(:tip, match: matches.second, user: users.second),
          create(:tip, match: matches.third, user: users.first),
          create(:tip, match: matches.third, user: users.second)
      ]
    end

    let(:aggregates) { [create(:phase), create(:phase)] }

    let(:matches) do
      [
          create(:match, aggregate: aggregates.first, position: 2),
          create(:match, aggregate: aggregates.first, position: 1),
          create(:match, aggregate: aggregates.second, position: 3),
      ]
    end

    describe 'if aggregate has no groups' do


      it 'returns all tips for given user_id and aggregate_id by given order' do
        actual_tips =subject.all_eager_by_user_id_and_aggregate_id_ordered_by_position(
            users.first.id, aggregates.first.id, order: 'matches.position')
        expect(actual_tips).to eq [tips.third, tips.first]
      end
    end

    describe 'if aggregate has groups' do

      let(:phase) { create(:phase) }
      let!(:groups) { [create(:group, parent: phase), create(:group, parent: phase), create(:group)] }

      let(:matches) do
        [
            create(:match, aggregate: groups.first, position: 2),
            create(:match, aggregate: groups.second, position: 1),
            create(:match, aggregate: groups.third, position: 3),
        ]
      end

      it 'returns all tips for given user_id and aggregate_id recursive by given order' do
        actual_tips = subject.all_eager_by_user_id_and_aggregate_id_ordered_by_position(
            users.first.id, phase.id, order: 'matches.position')
        expect(actual_tips).to eq [tips.third, tips.first]
      end
    end

    describe 'if no order is given' do

      it 'returns tips ordered by match ids' do
        actual_tips = subject.all_eager_by_user_id_and_aggregate_id_ordered_by_position(
            users.first.id, aggregates.first.id)
        expect(actual_tips).to eq [tips.first, tips.third]
      end
    end
  end
end

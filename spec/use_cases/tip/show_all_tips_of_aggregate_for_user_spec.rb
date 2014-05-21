describe ShowAllTipsOfAggregateForUser do

  let(:tournament) { Tournament.new }
  let(:presentable) { double('ShowTipsOfPhaseForUserPresentable') }

  let(:phases) do
    [
        create(:phase),
        create(:phase),
        create(:phase)
    ]
  end

  let(:groups) do
    [
        create(:group, parent: phases.first),
        create(:group, parent: phases.first)
    ]
  end

  let(:user) { create(:user) }

  let(:matches) do
    [
        create(:match, date: 1.day.ago, aggregate: groups.first, position: 1),
        create(:match, date: 1.day.ago, aggregate: groups.first, position: 2),
        create(:match, date: 1.day.ago, aggregate: groups.second, position: 3),
        create(:match, date: 1.day.ago, aggregate: groups.second, position: 4),
        create(:match, date: 2.day.from_now, aggregate: phases.second, position: 5),
        create(:match, date: 2.day.from_now, aggregate: phases.second, position: 6),
        create(:match, date: 3.day.from_now, aggregate: phases.third, position: 7),
        create(:match, date: 3.day.from_now, aggregate: phases.third, position: 8),
    ]
  end

  let(:tips) do
    [
        # we must set score_team_1: nil, score_team_2: nil of some tips belonging to match in the past
        # where it isn't allowed to change the result
        create(:tip, match: matches.first, user: user, score_team_1: nil, score_team_2: nil),
        create(:tip, match: matches.second, user: user, score_team_1: nil, score_team_2: nil),
        create(:tip, match: matches.third, user: user, score_team_1: nil, score_team_2: nil),
        create(:tip, match: matches.fourth, user: user, score_team_1: nil, score_team_2: nil),
        create(:tip, match: matches.fifth, user: user),
        create(:tip, match: matches[5], user: user),
        create(:tip, match: matches[6], user: user),
        create(:tip, match: matches[7], user: user),
        create(:tip, match: matches.first, score_team_1: nil, score_team_2: nil)
    ]
  end

  before :each do
    tips
  end

  describe '#run_with_presentable' do

    context 'when current_aggregate_id given' do

      subject do
        ShowAllTipsOfAggregateForUser.new(
            tournament: tournament,
            user_id: user.id,
            current_aggregate_id: phases.first.to_param
        )
      end

      it 'should set current aggregate and set matches tips of users to presentable' do
        #in this example we test the case that a phase consists of groups

        expect(presentable).to receive(:current_aggregate=).with(phases.first)
        expect(presentable).to receive(:tips=) do |actual_tips|
          expect(actual_tips).to eq [tips.first, tips.second, tips.third, tips.fourth]
        end

        subject.run_with_presentable(presentable)
      end
    end

    context 'when current_aggregate_id is not given' do

      subject do
        ShowAllTipsOfAggregateForUser.new(
            tournament: tournament,
            user_id: user.id,
        )
      end

      it 'should determine and set current phase and set matches tips of users to presentable' do
        #in this example we test the case that a phase consists of no group

        expect(presentable).to receive(:current_aggregate=).with(phases.second)
        expect(presentable).to receive(:tips=) do |actual_tips|
          expect(actual_tips).to eq [tips[4], tips[5]]
        end

        subject.run_with_presentable(presentable)
      end
    end
  end

end
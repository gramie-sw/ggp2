describe Matches::Create do

  subject { Matches::Create }

  let(:match_attributes) do
    {
        position: 1,
        aggregate_id: phase.id,
        placeholder_team_1: 'Team 1',
        placeholder_team_2: 'Team 2',
        date: Time.now
    }
  end

  let(:phase) { create(:phase) }

  describe '#run' do

    describe 'if match_attributes are valid' do

      it 'returns created Match' do
        match = subject.run(match_attributes: match_attributes)

        expect(match).to be_instance_of Match
        expect(match).to be_persisted
        expect(match).not_to be_changed
        expect(match.position).to be 1
        expect(match.aggregate).to eq phase
      end

      it 'creates tip for every existing player' do
        users = [create(:admin), create(:player), create(:player)]

        match = subject.run(match_attributes: match_attributes)

        tips = Tip.all
        expect(tips.count).to be 2
        expect(tips[0].user_id).to be users[1].id
        expect(tips[0].match_id).to be match.id
        expect(tips[1].user_id).to be users[2].id
        expect(tips[1].match_id).to be match.id
      end
    end

    describe 'if match_attributes are invalid' do

      before :each do
        match_attributes[:position] = nil
      end

      it 'returns unsaved Match with errors' do
        match = subject.run(match_attributes: match_attributes)

        expect(match).to be_instance_of Match
        expect(match).not_to be_persisted
        expect(match.errors).to be_present
      end

      it 'creates no tips' do
        create(:admin); create(:player); create(:player)

        subject.run(match_attributes: match_attributes)
        expect(Tip.count).to be 0
      end
    end
  end
end
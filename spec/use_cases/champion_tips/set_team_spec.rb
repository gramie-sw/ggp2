describe ChampionTips::SetTeam do

  subject { ChampionTips::SetTeam }

  let!(:champion_tip) { create(:champion_tip) }
  let(:team) { create(:team) }

  describe '#run' do

    let(:current_user) { create(:user) }

    context 'when tournament not started' do

      it 'returns updated champion_tip with no errors if team_id valid' do
        allow_any_instance_of(Tournament).to receive(:started?).and_return(false)

        actual_champion_tip = subject.run(id: champion_tip.id, team_id: team.id)

        expect(actual_champion_tip).to eq champion_tip
        expect(actual_champion_tip).not_to be_changed
        expect(actual_champion_tip.team_id).to eq team.id
        expect(actual_champion_tip.errors).to be_blank
      end

      it 'returns not updated champion_tip with errors if team_id is not valid' do
        allow_any_instance_of(Tournament).to receive(:started?).and_return(false)

        actual_champion_tip = subject.run(id: champion_tip.id, team_id: team.id+1)

        expect(actual_champion_tip).to eq champion_tip
        expect(actual_champion_tip).to be_changed
        expect(actual_champion_tip.team_id).not_to eq team.id
        expect(actual_champion_tip.errors[:team]).to be_present
      end
    end

    context 'when tournament started' do

      it 'returns not updated champion_tip with base error' do

        allow_any_instance_of(Tournament).to receive(:started?).and_return(true)

        actual_champion_tip = subject.run(id: champion_tip.id, team_id: team.id)

        expect(actual_champion_tip).to eq champion_tip
        expect(actual_champion_tip).not_to be_changed
        expect(actual_champion_tip.team_id).not_to eq team.id
        expect(actual_champion_tip.errors.messages[:base]).to eq [I18n.t('errors.messages.champion_tip_changeable_after_tournament_started')]
      end
    end
  end
end
describe UpdateChampionTip do

  let(:champion_tip) { create(:champion_tip) }
  let(:team) { create(:team)}


  let(:new_attributes) do
    {
      team_id: team.id
    }
  end

  before :each do
    champion_tip
  end

  describe '#run' do

    context 'when player' do

      let(:current_user) { create(:user) }

      before :each do
        current_user
      end

      context 'when tournament not started' do

        it 'should return result successful true and updated champion_tip' do

          allow_any_instance_of(Tournament).to receive(:started?).and_return(false)

          result = subject.run(current_user: current_user, champion_tip_id: champion_tip.id, attributes: new_attributes)

          expect(result.successful).to be_truthy
          champion_tip.reload
          expect(result.champion_tip).to eq champion_tip
        end
      end

      context 'when tournament started' do

        it 'should return result successful false and champion_tip with base error' do

          allow_any_instance_of(Tournament).to receive(:started?).and_return(true)

          result = subject.run(current_user: current_user, champion_tip_id: champion_tip.id, attributes: new_attributes)

          expect(result.successful).to be_falsey
          expect(result.champion_tip).to eq champion_tip
          expect(result.champion_tip.errors.messages[:base]).to eq [I18n.t('errors.messages.champion_tip_changeable_after_tournament_started')]
        end
      end
    end


    context 'when admin' do

      let(:current_user) { create(:admin) }

      before :each do
        current_user
      end

      it 'should return result successful true and updated champion_tip' do

        allow_any_instance_of(Tournament).to receive(:started?).and_return(true)

        result = subject.run(current_user: current_user, champion_tip_id: champion_tip.id, attributes: new_attributes)

        expect(result.successful).to be_truthy
        champion_tip.reload
        expect(result.champion_tip).to eq champion_tip
      end
    end
  end
end
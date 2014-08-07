describe ChampionTipPresenter do

  let(:tournament) { instance_double('Tournament') }
  let(:user_is_current_user) { true }
  let(:champion_tip_team) { Team.new(country: 'DE') }
  let(:champion_tip) { ChampionTip.new(id: 5, team: champion_tip_team) }

  subject do
    ChampionTipPresenter.
        new(champion_tip: champion_tip, tournament: tournament, user_is_current_user: user_is_current_user)
  end

  it { is_expected.to respond_to :champion_tip= }

  it 'should delegate #id to ChampionTip#id' do
    expect(subject.id).to eq 5
  end

  describe '#show?' do

    context 'when user is current user' do

      it 'should return true' do
        expect(subject.show?).to be_truthy
      end
    end

    context 'if user is not current user' do

      let(:user_is_current_user) { false }

      context 'if champion is tippable' do

        it 'should return false' do
          allow(tournament).to receive(:champion_tippable?).and_return(true)
          expect(subject.show?).to be_falsey
        end
      end

      context 'if champion is not tippable' do

        it 'should return false' do
          allow(tournament).to receive(:champion_tippable?).and_return(false)
          expect(subject.show?).to be_truthy
        end
      end
    end
  end


  describe '#tippable?' do

    before :each do
      allow(tournament).to receive(:champion_tip_deadline).and_return(Time.new)
      allow(tournament).to receive(:champion_tippable?).and_return(true)
    end

    context 'if user is current user and tournament has champion tip deadline and champion is tippable' do

      it 'should return true' do
        expect(subject.tippable?).to be_truthy
      end
    end

    context 'if user_is_not_current_user' do

      let(:user_is_current_user) { false }

      it 'should return false' do
        expect(subject.tippable?).to be_falsey
      end
    end

    context 'if tournament has no champion tip deadline ' do

      before :each do
        allow(tournament).to receive(:champion_tip_deadline).and_return(nil)
      end

      it 'should return false' do
        expect(subject.tippable?).to be_falsey
      end
    end

    context 'if champion is not tippable ' do

      before :each do
        allow(tournament).to receive(:champion_tippable?).and_return(false)
      end

      it 'should return false' do
        expect(subject.tippable?).to be_falsey
      end
    end
  end

  describe '#team_abbreviation' do

    context 'when ChampionTip has team' do

      it "should return abbreviation of Team in ChampionTip" do
        expect(subject.team_abbreviation).to eq 'DE'
      end
    end

    context 'when ChampionTip has no team' do

      it "should return nil" do
        champion_tip.team = nil
        expect(subject.team_abbreviation).to be_nil
      end
    end
  end

  describe '#team_name_or_missing_message' do

    context 'when ChampionTip has team' do

      it "should return name of Team in ChampionTip" do
        expect(subject.team_name_or_missing_message).to eq I18n.t('DE', :scope => 'countries')
      end
    end

    context 'when ChampionTip has no team' do

      it "should return missing message" do
        champion_tip.team = nil
        expect(subject.team_name_or_missing_message).to eq t('tip.not_present')
      end
    end
  end

  describe '#deadline_message' do

    it 'should return deadline message' do
      expected_deadline_time = Time.now + 2.days
      expect(tournament).to receive(:champion_tip_deadline).and_return(expected_deadline_time)
      expect(subject.deadline_message).to eq t('general.changeable_until', date: l(expected_deadline_time))
    end
  end
end
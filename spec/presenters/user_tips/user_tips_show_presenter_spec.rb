describe UserTipsShowPresenter do

  let(:user) { create(:player) }
  let(:user_is_current_user) { true }
  let(:tournament) { Tournament.new }
  subject { UserTipsShowPresenter.new(user: user, tournament: tournament, user_is_current_user: user_is_current_user) }

  it { should respond_to(:user_is_current_user?) }

  describe '#title' do

    context 'if user is current_user' do
      it { subject.title.should eq t('tip.yours') }
    end

    context 'if user is not current_user' do
      let(:user_is_current_user) { false }
      it { subject.title.should eq t('tip.all') }
    end
  end

  describe '#subtitle' do

    context 'if user is current_user' do
      it { subject.subtitle.should eq '' }
    end

    context 'if user is not current_user' do
      let(:user_is_current_user) { false }
      it { subject.subtitle.should eq t('general.of_subject', subject: user.nickname) }
    end
  end

  describe '#show_as_form?' do

    let(:aggregate) { create(:aggregate) }

    context 'if user is current_user' do

      let(:user_is_current_user) { true }
      let(:relation) { double('MatchesRelation') }

      before :each do
        aggregate.should_receive(:future_matches).and_return(relation)
      end

      context 'if given aggregate has any future matches' do

        it 'should return true' do
          relation.should_receive(:exists?).and_return(true)
          subject.show_as_form?(aggregate).should be_true
        end
      end

      context 'if given aggregate has not any future matches' do

        it 'should return false' do
          relation.should_receive(:exists?).and_return(false)
          subject.show_as_form?(aggregate).should be_false
        end
      end
    end

    context 'if user is not current_user' do

      let(:user_is_current_user) { false }

      it 'should return false' do
        subject.show_as_form?(aggregate).should be_false
      end
    end
  end

  describe '#tip_presenter_for' do

    let(:matches) do
      [
          create(:match),
          create(:match),
      ]
    end

    let(:tips) do
      [
          create(:tip, match: matches.first, user: user),
          create(:tip, match: matches.first),
          create(:tip, match: matches.second, user: user)
      ]
    end

    before :each do
      tips
    end

    it 'should return tip_presenter for given match and user' do
      actual_tip_presenter = subject.tip_presenter_for(matches.first)
      #rspec's be_kind_of matcher doesn't work for subclasses of DelegateClass
      actual_tip_presenter.kind_of?(TipPresenter).should be_true
      actual_tip_presenter.__getobj__.should eq tips.first
    end

    #TODO write performance test to ensure that matches is includes

    it 'should cache tip_presenter' do
      #rspec's be_kind_of matcher doesn't work for subclasses of DelegateClass when comparing objects directly
      subject.tip_presenter_for(matches.first).object_id.should be subject.tip_presenter_for(matches.first).object_id
    end
  end

  describe '#champion_tip_deadline' do

    it 'should return value from Tournament#champion_tip_deadline' do
      tournament.should_receive(:champion_tip_deadline).and_return(:deadline)
      subject.champion_tip_deadline.should eq :deadline
    end
  end

  describe '#show_champion_tip?' do

    context 'if user is current user' do

      it 'should return true' do
        subject.show_champion_tip?.should be_true
      end
    end

    context 'if user is not current user' do

      let(:user_is_current_user) { false }

      context 'if champion is tippable' do

        it 'should return false' do
          tournament.stub(:champion_tippable?).and_return(true)
          subject.show_champion_tip?.should be_false
        end
      end

      context 'if champion is not tippable' do

        it 'should return false' do
          tournament.stub(:champion_tippable?).and_return(false)
          subject.show_champion_tip?.should be_true
        end
      end
    end
  end

  describe '#champion_tippable?' do

    before :each do
      tournament.stub(:champion_tip_deadline).and_return(Time.new)
      tournament.stub(:champion_tippable?).and_return(true)
    end

    context 'if user is current user and tournament has champion tip deadline and champion is tippable' do

      it 'should return true' do
        subject.champion_tippable?.should be_true
      end
    end

    context 'if user_is_not_current_user' do

      let(:user_is_current_user) { false }

      it 'should return false' do
        subject.champion_tippable?.should be_false
      end
    end

    context 'if tournament has no champion tip deadline ' do

      before :each do
        tournament.stub(:champion_tip_deadline).and_return(nil)
      end

      it 'should return false' do
        subject.champion_tippable?.should be_false
      end
    end

    context 'if champion is not tippable ' do

      before :each do
        tournament.stub(:champion_tippable?).and_return(false)
      end

      it 'should return false' do
        subject.champion_tippable?.should be_false
      end
    end
  end

  describe '#champion_tip_team' do

    context 'if user has champion tipped' do

      it 'should return champion tip team' do
        expected_team = create(:champion_tip, user: user).team
        subject.champion_tip_team.should eq expected_team
      end
    end

    context 'if user has champion not tipped' do

      it 'should return null' do
        subject.champion_tip_team.should be_nil
      end
    end
  end

  describe '#champion_tip_id' do

    context 'if champion_tip present' do

      it 'should return champion_tip id' do
        expected_champion_tip = create(:champion_tip, user: user)
        subject.champion_tip_id.should eq expected_champion_tip.id
      end
    end

    context 'if champion_tip is not present' do

      it 'should return nil' do
        subject.champion_tip_id.should be_nil
      end
    end
  end
end
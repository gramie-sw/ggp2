describe ProfilesShowPresenter do

  let(:user) { User.new id: 5 }
  let(:is_for_current_user) { true }
  let(:tournament) { Tournament.new }
  let(:current_section) { :statistic }
  subject do
    ProfilesShowPresenter.new(user: user,
                              tournament: tournament,
                              is_for_current_user: is_for_current_user,
                              section: current_section)
  end

  it 'should respond to user' do
    subject.should respond_to :user
  end

  it 'should respond to is_for_current_user?' do
    subject.should respond_to :is_for_current_user?
  end

  describe '#initialze' do

    context 'if section is a symbol' do

      let(:current_section) { 'statistic' }

      it 'should cast given section to symbol' do
        subject.instance_variable_get(:@section).should eq :statistic
      end
    end

    context 'if section is nil' do
      let(:current_section) { nil }

      it 'should not try to cast nil' do
        subject.instance_variable_get(:@section).should be_nil
      end
    end
  end

  describe '#title' do

    context 'when is_for_current_user is true' do
      it { subject.title.should eq t('profile.yours') }
    end

    context 'when is_for_current_user is false' do
      let(:is_for_current_user) { false }
      it { subject.title.should eq t('general.profile.one') }
    end
  end

  describe '#subtitle' do

    context 'when is_for_current_user is true' do
      it { subject.subtitle.should eq '' }
    end

    context 'when is_for_current_user is false' do
      let(:is_for_current_user) { false }
      it { subject.subtitle.should eq t('general.of_subject', subject: user.nickname) }
    end
  end

  describe '#current_section' do

    context 'if given section is in available section' do

      it 'should return given section' do
        subject.current_section.should eq current_section
      end
    end

    context 'if given section is null' do

      let(:section) { :wrong_section }

      it 'should return first of available sections' do
        subject.current_section.should eq subject.available_sections.first
      end
    end
  end

  describe '#available_sections' do

    it 'should return array of available sections' do
      subject.available_sections.should eq [:statistic, :badges, :user_data]
    end
  end

  describe '#user_statstic' do

    let(:expected_user_statistic) { double('UserStatistic') }
    let(:current_user_ranking_item) { double('RankingItem') }

    it 'should return player statistic for given user' do

      ShowSingleUserCurrentRanking.any_instance.should_receive(:run).with(user.id).and_return(current_user_ranking_item)
      UserStatistic.should_receive(:new).
          with(user: user, tournament: tournament, current_ranking_item: current_user_ranking_item).
          and_return(expected_user_statistic)

      subject.user_statistic
    end

    it 'should cache object' do
      ShowSingleUserCurrentRanking.any_instance.should_receive(:run).and_return(current_user_ranking_item)
      UserStatistic.should_receive(:new).and_return(expected_user_statistic)

      subject.user_statistic
      subject.user_statistic
    end
  end
end

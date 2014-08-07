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

  it { is_expected.to respond_to(:badges=, :badges)}

  it 'should respond to user' do
    expect(subject).to respond_to :user
  end

  it 'should respond to is_for_current_user?' do
    expect(subject).to respond_to :is_for_current_user?
  end

  describe '#initialze' do

    context 'if section is a symbol' do

      let(:current_section) { 'statistic' }

      it 'should cast given section to symbol' do
        expect(subject.instance_variable_get(:@section)).to eq :statistic
      end
    end

    context 'if section is nil' do
      let(:current_section) { nil }

      it 'should not try to cast nil' do
        expect(subject.instance_variable_get(:@section)).to be_nil
      end
    end
  end

  describe '#title' do

    context 'when is_for_current_user is true' do
      it { expect(subject.title).to eq t('profile.yours') }
    end

    context 'when is_for_current_user is false' do
      let(:is_for_current_user) { false }
      it { expect(subject.title).to eq t('general.profile.one') }
    end
  end

  describe '#subtitle' do

    context 'when is_for_current_user is true' do
      it { expect(subject.subtitle).to eq '' }
    end

    context 'when is_for_current_user is false' do
      let(:is_for_current_user) { false }
      it { expect(subject.subtitle).to eq t('general.of_subject', subject: user.nickname) }
    end
  end

  describe '#current_section' do

    context 'if given section is in available section' do

      it 'should return given section' do
        expect(subject.current_section).to eq current_section
      end
    end

    context 'if given section is null' do

      let(:section) { :wrong_section }

      it 'should return first of available sections' do
        expect(subject.current_section).to eq subject.available_sections.first
      end
    end
  end

  describe '#available_sections' do

    it 'should return array of available sections' do
      expect(subject.available_sections).to eq [:statistic, :badges, :user_data]
    end
  end

  describe '#user_statstic' do

    let(:expected_user_statistic) { double('UserStatistic') }
    let(:current_user_ranking_item) { double('RankingItem') }

    it 'should return player statistic for given user' do

      expect_any_instance_of(ShowSingleUserCurrentRanking).to receive(:run).with(user.id).and_return(current_user_ranking_item)
      expect(UserStatistic).to receive(:new).
          with(user: user, tournament: tournament, current_ranking_item: current_user_ranking_item).
          and_return(expected_user_statistic)

      subject.user_statistic
    end

    it 'should cache object' do
      expect_any_instance_of(ShowSingleUserCurrentRanking).to receive(:run).and_return(current_user_ranking_item)
      expect(UserStatistic).to receive(:new).and_return(expected_user_statistic)

      subject.user_statistic
      subject.user_statistic
    end
  end
end

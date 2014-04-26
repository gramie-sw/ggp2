describe 'user_tips/show.slim' do

  let(:user) { create(:player) }
  let(:champion_tip) { create(:champion_tip, user: user) }
  let(:user_is_current_user) { true }
  let(:presenter) do
    UserTipsShowPresenter.new(user: user,
                              tournament: Tournament.new,
                              user_is_current_user: user_is_current_user)
  end

  before :each do
    champion_tip
    create(:aggregate)
    assign(:presenter, presenter)
  end

  describe 'tips_table' do

    context 'if presenter#show_as_form? returns true' do

      it 'should be showed as form' do
        presenter.stub(:show_as_form?).and_return(true)
        render
        rendered.should have_css 'form'
      end
    end

    context 'if presenter#show_as_form? returns false' do

      it 'should be showed as form' do
        presenter.stub(:show_as_form?).and_return(false)
        render
        rendered.should_not have_css 'form'
      end
    end
  end

  describe '#champion_tip' do

    context 'if presenter#show_champion_tip? returns true' do

      it 'should be showed' do
        presenter.stub(:show_champion_tip?).and_return(true)
        render
        rendered.should match ChampionTip.model_name.human
      end
    end

    context 'if presenter#show_champion_tip? returns false' do

      it 'should be showed' do
        presenter.stub(:show_champion_tip?).and_return(false)
        render
        rendered.should_not match ChampionTip.model_name.human
      end
    end
  end

  describe '#champion_tip link' do

    let(:champion_tip_deadline) { 2.days.from_now }

    before :each do
      presenter.stub(:show_champion_tip?).and_return(true)
      presenter.stub(:champion_tip_deadline).and_return(champion_tip_deadline)
    end

    let(:champion_tip_link_css) { "a[href='#{edit_champion_tip_path(champion_tip)}']" }

    context 'if presenter#champion_tippable? returns true' do

      it 'should be showed' do
        presenter.stub(:champion_tippable?).and_return(true)
        render
        rendered.should have_css champion_tip_link_css
      end
    end

    context 'if presenter#champion_tippable? returns false' do

      it 'should be showed' do
        presenter.stub(:champion_tippable?).and_return(false)
        render
        rendered.should_not have_css champion_tip_link_css
      end
    end
  end

  describe '#champion_tip deadline message' do

    let(:champion_tip_deadline) { 2.days.from_now }

    before :each do
      presenter.stub(:show_champion_tip?).and_return(true)
      presenter.stub(:champion_tip_deadline).and_return(champion_tip_deadline)
    end

    let(:champion_tip_deadline_message_css) do
      ['div#champion-tip', text: t('general.changeable_until', date: l(champion_tip_deadline))]
    end

    context 'if presenter#champion_tippable? returns true' do

      it 'should be showed' do
        presenter.stub(:champion_tippable?).and_return(true)
        render
        rendered.should have_css *champion_tip_deadline_message_css
      end
    end

    context 'if presenter#champion_tippable? returns false' do

      it 'should be showed' do
        presenter.stub(:champion_tippable?).and_return(false)
        render
        rendered.should_not have_css *champion_tip_deadline_message_css
      end
    end
  end

  describe 'champion tip team' do

    let(:champion_tip_deadline) { 2.days.from_now }

    before :each do
      presenter.stub(:show_champion_tip?).and_return(true)
      presenter.stub(:champion_tip_deadline).and_return(champion_tip_deadline)
    end

    context 'if presenter#champion_tip_team present' do

      it 'should be displayed' do
        render
        rendered.should have_css 'div#champion-tip', text: champion_tip.team.name
        rendered.should_not have_css 'div#champion-tip', text: t('tip.not_present')
      end
    end

    context 'if presenter#champion_tip_team no present' do

      it 'should not be displayed, show not present message instead' do
        presenter.stub(:champion_tip_team).and_return(nil)
        render
        rendered.should have_css 'div#champion-tip', text: t('tip.not_present')
      end
    end
  end

  describe 'hint text' do

    let(:hint_css) { t('tip.description.for_showing_others') }

    context 'when user is current_user' do

      it 'should not be displayed' do
        allow(presenter).to receive(:user_is_current_user?).and_return(true)
        render
        expect(rendered).not_to include hint_css
      end
    end

    context 'when user is not current_user' do

      it 'should be displayed' do
        allow(presenter).to receive(:user_is_current_user?).and_return(false)
        render
        expect(rendered).to include hint_css
      end
    end
  end
end
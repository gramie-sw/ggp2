describe 'user_tips/_champion_tip.slim', :type => :view do

  let(:presenter) do
    presenter = double('ChampionTipPresenter')
    presenter.as_null_object
    presenter
  end

  let(:partial) do
    {
        partial: 'user_tips/champion_tip',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            presenter: presenter,
        }
    }
  end

  let(:champion_title) {'World Champion'}

  before :each do
    allow(view).to receive(:champion_title).and_return(champion_title)
    allow(presenter).to receive(:show?).and_return(true)
  end

  describe 'champion_tip' do

    context 'if presenter#show? returns true' do

      it 'should be showed' do
        expect(presenter).to receive(:show?).and_return(true)
        render partial
        expect(rendered).to match t('general.champion_tip.one', champion_title: champion_title)
      end
    end

    context 'if presenter#show? returns false' do

      it 'should be showed' do
        expect(presenter).to receive(:show?).and_return(false)
        render partial
        expect(rendered).not_to match t('general.champion_tip.one', champion_title: champion_title)
      end
    end
  end

  describe '#link' do

    let(:id) { 7 }
    let(:champion_tip_link_css) { "a[href='#{edit_champion_tip_path(id)}']" }

    before :each do
      allow(presenter).to receive(:id).and_return(id)
    end

    context 'if presenter#tippable? returns true' do

      it 'should be showed' do
        expect(presenter).to receive(:tippable?).and_return(true)
        render partial
        expect(rendered).to have_css champion_tip_link_css
      end
    end

    context 'if presenter#champion_tippable? returns false' do

      it 'should be showed' do
        expect(presenter).to receive(:tippable?).at_least(:once).and_return(false)
        render partial
        expect(rendered).not_to have_css champion_tip_link_css
      end
    end
  end

  describe '#deadline_message' do

    let(:deadline_message_css) { ['div', {text: 'deadline message'}] }

    before :each do
      allow(presenter).to receive(:deadline_message).and_return('deadline message')
    end

    context 'if presenter#tippable? returns true' do

      it 'should be showed' do
        expect(presenter).to receive(:tippable?).and_return(true).at_least(:once)
        render partial
        expect(rendered).to have_css *deadline_message_css
      end
    end

    context 'if presenter#champion_tippable? returns false' do

      it 'should not be showed' do
        expect(presenter).to receive(:tippable?).and_return(false).at_least(:once)
        render partial
        expect(rendered).not_to have_css *deadline_message_css
      end
    end
  end

end

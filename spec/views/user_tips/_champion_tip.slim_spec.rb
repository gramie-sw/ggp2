describe 'user_tips/_champion_tip.slim' do

  let(:presenter) { instance_double('ChampionTipPresenter') }

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

  before :each do
    allow(presenter).to receive(:show?).and_return(true)
    allow(presenter).to receive(:tippable?).and_return(true)
    allow(presenter).to receive(:team_abbreviation)
    allow(presenter).to receive(:team_name_or_missing_message)
    allow(presenter).to receive(:deadline_message)
    allow(presenter).to receive(:id).and_return(5)
  end

  describe 'champion_tip' do

    context 'if presenter#show? returns true' do

      it 'should be showed' do
        presenter.should_receive(:show?).and_return(true)
        render partial
        rendered.should match ChampionTip.model_name.human
      end
    end

    context 'if presenter#show? returns false' do

      it 'should be showed' do
        presenter.should_receive(:show?).and_return(false)
        render partial
        rendered.should_not match ChampionTip.model_name.human
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
        presenter.should_receive(:tippable?).and_return(true)
        render partial
        rendered.should have_css champion_tip_link_css
      end
    end

    context 'if presenter#champion_tippable? returns false' do

      it 'should be showed' do
        presenter.should_receive(:tippable?).and_return(false)
        render partial
        rendered.should_not have_css champion_tip_link_css
      end
    end
  end

end

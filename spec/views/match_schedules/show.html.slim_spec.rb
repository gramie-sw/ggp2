describe 'match_schedules/show.html.slim', type: :view do

  context 'when no aggregates exists' do

    let(:presenter) { MatchSchedulePresenter.new(current_aggregate: nil) }

    before :each do
      assign(:presenter, presenter)
    end

    it 'should render empty page with hint' do
      render
      expect(rendered).to include t('match_schedule.not_present')
    end
  end
end
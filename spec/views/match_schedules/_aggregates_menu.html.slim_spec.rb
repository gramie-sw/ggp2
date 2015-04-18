describe 'match_schedules/_aggregates_menu.html.slim_spec.rb' do

  let(:partial) do
    {
        partial: 'match_schedules/aggregates_menu',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            all_phases: all_phases,
            current_phase: current_phase,
            all_groups: all_groups,
            current_group: current_group
        }
    }
  end

  let(:all_phases) do
    [
        Aggregate.new(id: 1, name: 'Phase 1'),
        Aggregate.new(id: 2, name: 'Phase 2'),
        Aggregate.new(id: 3, name: 'Phase 3'),
    ]
  end

  let(:current_phase) { all_phases.second }


  let(:all_groups) do
    [
        Aggregate.new(id: 1, name: 'Group 1'),
        Aggregate.new(id: 2, name: 'Group 2'),
        Aggregate.new(id: 3, name: 'Group 3'),
    ]
  end

  let(:current_group) { all_groups.second }

  before :each do
    allow(view).to receive(:url_for)
  end

  describe 'groups menu' do

    groups_menu_css = '.groups-menu'

    context 'if all_groups not blank' do

      it 'should be displayed' do
        render partial
        expect(rendered).to have_css(groups_menu_css, count: 2)
      end
    end

    context 'if all_groups are blank' do

      let(:all_groups) { [] }

      it 'should be displayed' do
        render partial
        expect(rendered).not_to have_css(groups_menu_css)
      end
    end
  end

end
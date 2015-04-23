describe 'match_schedules/_actions_menu.html.slim.rb' do

  let(:partial) do
    {
        partial: 'match_schedules/actions_menu',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            phase: phase,
            group: group
        }
    }
  end

  let(:phase) { Aggregate.new(id: 545) }
  let(:group) { Aggregate.new(id: 575) }

  describe 'add games link aggregate_id parameter' do

    context 'if group is present' do

      it 'has group_id as value' do
        render partial
        expect(rendered).to include new_match_path(aggregate_id: group.id)
      end
    end

    context 'if group is not present' do

      let(:group) { nil }

      it 'has group_id as value' do
        render partial
        expect(rendered).to include new_match_path(aggregate_id: phase.id)
      end
    end

  end

  describe 'add groups link' do

    let(:add_group_link_label) { t('model.messages.create', model: t('general.group.other')) }

    context 'if group is present' do

      it 'is not shown' do
        render partial
        expect(rendered).not_to have_css('a', text: add_group_link_label)
      end
    end

    context 'if group is not present' do

      let(:group) { nil }

      it 'is shown' do
        render partial
        expect(rendered).to have_css('a', text: add_group_link_label, count: 2)
      end
    end
  end

  describe 'edit group link' do

    let(:edit_group_link_label) { t('model.messages.edit', model: t('general.group.one')) }

    context 'if group is present' do

      it 'is shown' do
        render partial
        expect(rendered).to have_css('a', text: edit_group_link_label, count: 2)
      end
    end

    context 'if group is not present' do

      let(:group) { nil }

      it 'is shown' do
        render partial
        expect(rendered).not_to have_css('a', text: edit_group_link_label)
      end
    end
  end

end

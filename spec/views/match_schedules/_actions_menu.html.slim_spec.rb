describe 'match_schedules/_actions_menu.html.slim_spec.rb' do

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

  describe 'add group link' do

    let(:add_group_link_label) { t('model.messages.add', model: t('general.group.other')) }

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

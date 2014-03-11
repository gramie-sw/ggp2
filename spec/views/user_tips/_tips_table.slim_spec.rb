describe 'user_tips/_tips_table.slim' do

  let(:show_as_form) { true }
  let(:tip) { create(:tip) }
  let(:user) { tip.user }
  let(:match) { tip.match }
  let(:presenter) do
    UserTipsShowPresenter.new(user: user,
                              tournament: Tournament.new,
                              user_is_current_user: false)
  end

  let(:partial_options) do
    {
        partial: 'user_tips/tips_table',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            presenter: presenter,
            aggregate: match.aggregate,
            show_as_form: show_as_form
        }
    }
  end

  describe 'form controls' do

    select_all_link_selector = "div.btn-toolbar a[onclick]"
    submit_button_selector = "div.btn-toolbar input[type='submit']"

    context 'if show_as_form is true' do

      it 'should be displayed' do
        render partial_options
        rendered.should have_css select_all_link_selector
        rendered.should have_css submit_button_selector
      end
    end

    context 'if show_as_form is true' do

      let(:show_as_form) { false }

      it 'should be displayed' do
        render partial_options
        rendered.should_not have_css select_all_link_selector
        rendered.should_not have_css submit_button_selector
      end
    end
  end

  describe 'table row' do

    let(:table_row_as_link_selector) { "tr.link-row[data-href='#{edit_multiple_tips_path(tip_ids: [tip.id])}']" }
    checkbox_selector = "tr input[type=checkbox]"

    context 'if show_as_form is true' do

      context 'if match is tippable' do

        it 'should be displayed as link' do
          Match.any_instance.should_receive(:tippable?).and_return(true)
          render partial_options
          rendered.should have_css table_row_as_link_selector
          rendered.should have_css checkbox_selector
        end
      end

      context 'if match is not tippable' do

        it 'should not be displayed as link' do
          Match.any_instance.should_receive(:tippable?).and_return(false)
          render partial_options
          rendered.should_not have_css table_row_as_link_selector
          rendered.should_not have_css checkbox_selector
        end
      end
    end

    context 'if show_as_form is false' do

      let(:show_as_form) { false }

      describe 'if show_as_form is false' do

        it 'should not be displayed as link' do
          Match.any_instance.should_not_receive(:tippable?)
          render partial_options
          rendered.should_not have_css table_row_as_link_selector
          rendered.should_not have_css checkbox_selector
        end
      end
    end
  end
end

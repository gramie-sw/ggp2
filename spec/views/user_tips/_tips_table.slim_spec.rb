describe 'user_tips/_tips_table.slim', :type => :view do

  let(:show_as_form) { true }
  let(:tip) { create(:tip) }
  let(:user) { tip.user }
  let(:match) { tip.match }
  let(:tip_presenters) do
    presenter = double('TipPresenter')
    presenter.as_null_object
    [presenter]
  end

  let(:partial_options) do
    {
        partial: 'user_tips/tips_table',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            tip_presenters: tip_presenters,
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
        expect(rendered).to have_css select_all_link_selector
        expect(rendered).to have_css submit_button_selector
      end
    end

    context 'if show_as_form is false' do

      let(:show_as_form) { false }

      it 'should not be displayed' do
        render partial_options
        expect(rendered).not_to have_css select_all_link_selector
        expect(rendered).not_to have_css submit_button_selector
      end
    end
  end

  describe 'table row' do

    let(:match_presenter) do
      presenter = double('MatchPresenter')
      presenter.as_null_object
      presenter
    end
    let(:table_row_as_link_selector) { "tr.link-row[data-href='#{edit_multiple_tips_path(tip_ids: [5])}']" }
    checkbox_selector = "tr input[type=checkbox]"

    before :each do
      allow(tip_presenters.first).to receive(:match_presenter).and_return(match_presenter)
      allow(tip_presenters.first).to receive(:id).and_return(5)
    end

    context 'if show_as_form is true' do

      context 'if match is tippable' do

        it 'should be displayed as link' do
          expect(match_presenter).to receive(:tippable?).and_return(true)
          render partial_options
          expect(rendered).to have_css table_row_as_link_selector
          expect(rendered).to have_css checkbox_selector
        end
      end

      context 'if match is not tippable' do

        it 'should not be displayed as link' do
          expect(match_presenter).to receive(:tippable?).and_return(false)
          render partial_options
          expect(rendered).not_to have_css table_row_as_link_selector
          expect(rendered).not_to have_css checkbox_selector
        end
      end
    end

    context 'if show_as_form is false' do

      let(:show_as_form) { false }

      describe 'if show_as_form is false' do

        it 'should not be displayed as link' do
          allow(match_presenter).to receive(:tippable?).and_return(false)
          render partial_options
          expect(rendered).not_to have_css table_row_as_link_selector
          expect(rendered).not_to have_css checkbox_selector
        end
      end
    end
  end
end

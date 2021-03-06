describe 'user_tips/show.slim', :type => :view do

  let(:current_user) { User.new }
  let(:presenter) do
    presenter = double('UserTipsPresenter')
    presenter.as_null_object
    presenter
  end

  before :each do
    assign(:presenter, presenter)
    view.define_singleton_method(:champion_title) {'World Champion'}
    allow(view).to receive(:current_user).and_return(current_user)
  end

  describe 'tips_table' do

    let(:tip_table_form_css) { 'form#tip-table-form' }

    context 'if presenter#show_as_form? returns true' do

      it 'should be showed as form' do
        allow(presenter).to receive(:show_as_form?).and_return(true)
        render
        expect(rendered).to have_css tip_table_form_css
      end
    end

    context 'if presenter#show_as_form? returns false' do

      it 'should be showed as form' do
        allow(presenter).to receive(:show_as_form?).and_return(false)
        render
        expect(rendered).not_to have_css tip_table_form_css
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
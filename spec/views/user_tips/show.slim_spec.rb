describe 'user_tips/show.slim' do

  let(:presenter) do
    presenter = instance_double('UserTipsShowPresenter')
    presenter.as_null_object
    presenter
  end

  before :each do
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
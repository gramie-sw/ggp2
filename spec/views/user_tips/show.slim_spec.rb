describe 'user_tips/show.slim' do

  let(:user) { create(:player) }
  let(:user_is_current_user) { true }
  let(:presenter) do
    UserTipsShowPresenter.new(user: user,
                              tournament: Tournament.new,
                              user_is_current_user: user_is_current_user)
  end

  before :each do
    create(:aggregate)
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
end
describe 'profiles/show.slim' do

  let(:user) { build(:player) }
  let(:is_for_current_user) { true }
  let(:presenter) do
    ProfilesShowPresenter.new(user: user, tournament: Tournament.new, is_for_current_user: is_for_current_user)
  end

  before :each do
    assign(:presenter, presenter)
  end

  describe 'e-mail' do

    context 'is user is current_user' do

      it 'should be displayed' do
        render
        rendered.should have_css('p', text: user.email)
      end
    end

    context 'is user is not current_user' do

      let(:is_for_current_user) { false }

      it 'should not be displayed' do
        render
        rendered.should_not have_css('p', text: user.email)
      end
    end
  end

  describe 'edit email link' do

    let(:edit_email_link_css) { "a[href='edit_email_link']" }

    context 'is user is current_user' do

      it 'should be displayed' do
        render
        rendered.should have_css edit_email_link_css
      end
    end

    context 'is user is current_user' do

      let(:is_for_current_user) { false }

      it 'should not be displayed' do
        render
        rendered.should_not have_css edit_email_link_css
      end
    end
  end

  describe 'edit password link' do

    let(:edit_password_link_css) { "a[href='edit_password_link']" }

    context 'is user is current_user' do

      it 'should be displayed' do
        render
        rendered.should have_css edit_password_link_css
      end
    end

    context 'is user is current_user' do

      let(:is_for_current_user) { false }

      it 'should not be displayed' do
        render
        rendered.should_not have_css edit_password_link_css
      end
    end
  end

end
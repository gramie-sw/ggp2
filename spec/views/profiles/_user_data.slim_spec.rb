describe 'profiles/_user_data.slim', :type => :view do

  let(:user) { build(:player, id: 5, created_at: Date.new) }
  let(:is_for_current_user) { true }
  let(:section) { :statistic }
  let(:presenter) do
    ProfilesShowPresenter.new(user: user, tournament: Tournament.new, is_for_current_user: is_for_current_user, section: section)
  end

  let(:partial_options) do
    {
        partial: 'profiles/user_data',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            presenter: presenter,
        }
    }
  end

  describe 'static-form' do

    let(:email_field_css) { ['.ggp2-static-form-label', {text: User.human_attribute_name(:email)}] }
    let(:password_field_css) { ['.ggp2-static-form-label', {text: User.human_attribute_name(:password)}] }
    let(:edit_link_css) { ['a', {text: t('model.messages.change', model: t('general.user_data'))}] }

    context 'when is_for_current_user is true' do


      it 'should display form controls special to current_user' do
        render partial_options

        expect(rendered).to have_css *email_field_css
        expect(rendered).to have_css *password_field_css
        expect(rendered).to have_css *edit_link_css
      end
    end

    context 'when is_for_current_user is true' do

      let(:is_for_current_user) { false }

      it 'should display form controls special to current_user' do
        render partial_options

        expect(rendered).not_to have_css *email_field_css
        expect(rendered).not_to have_css *password_field_css
        expect(rendered).not_to have_css *edit_link_css
      end
    end
  end

end
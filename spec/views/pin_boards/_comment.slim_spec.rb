describe 'pin_boards/_comment.slim', :type => :view do

  let(:comment) { build(:comment, id: 5, created_at: Time.current) }
  let(:is_for_current_user) { true }
  let(:is_admin) { false }
  let(:comment_presenter) { CommentsPresenter.new(comment: comment, is_for_current_user: is_for_current_user, is_admin: is_admin) }

  let(:partial_options) do
    {
        partial: 'pin_boards/comment',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            comment_presenter: comment_presenter,
        }
    }
  end

  describe 'edit link' do

    context 'when presenter#is_for_current_user? is true' do

      it 'should be displayed' do
        render partial_options
        expect(rendered).to have_css("a[href='#{edit_comment_path(comment)}']")
      end
    end

    context 'when presenter#is_for_current_user? is false' do

      let(:is_for_current_user) { false }

      it 'should be displayed' do
        render partial_options
        expect(rendered).not_to have_css("a[href='#{edit_comment_path(comment)}']")
      end
    end
  end
end
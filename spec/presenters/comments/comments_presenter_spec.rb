describe CommentsPresenter do

  let(:comment) { build(:comment) }
  let(:is_for_current_user) { true }
  subject { CommentsPresenter.new(comment: comment, is_for_current_user: is_for_current_user) }

  it 'should respond to is_for_current_user?' do
    #matcher respond_to didn't worked with DelegateClass in rspec-expectations
    subject.respond_to?(:is_for_current_user).should be_true
  end

end
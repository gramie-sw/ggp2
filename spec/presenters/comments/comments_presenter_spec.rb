describe CommentsPresenter do

  let(:comment) { build(:comment) }
  let(:is_for_current_user) { true }
  let(:is_admin) { false }
  subject { CommentsPresenter.new(comment: comment, is_for_current_user: is_for_current_user, is_admin: is_admin) }

  it 'should respond to is_for_current_user?' do
    #matcher respond_to didn't worked with DelegateClass in rspec-expectations
    subject.respond_to?(:is_for_current_user).should be_true
  end

  describe 'editable ' do

    context 'is for current user' do

      it 'should be editable' do
        expect(subject.editable?).to be_true
      end
    end

    context 'is not for current user' do

      let(:is_for_current_user) { false }

      it 'should not be editable' do
        expect(subject.editable?).to be_false

      end
    end
  end

  describe 'destroyable' do

    context 'admin' do

      let(:is_admin) { true }

      it 'should be destroyable' do
        expect(subject.destroyable?).to be_true
      end
    end

    context 'not admin' do

      it 'should not be destroyable' do
        expect(subject.destroyable?).to be_false
      end
    end
  end
end
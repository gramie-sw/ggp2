describe Comment do

  it 'should have valid factory' do
    build(:comment).should be_valid
  end

  describe 'validations' do

    describe 'user' do
      it { should validate_presence_of :user }
    end

    describe 'content' do
      it { should validate_presence_of :content }
      it { should ensure_length_of(:content).is_at_most(500) }
    end
  end

  describe 'associations' do

    it {should belong_to :user}
  end
end

describe Comment, :type => :model do

  it 'should have valid factory' do
    expect(build(:comment)).to be_valid
  end

  describe 'validations' do

    describe 'user' do
      it { is_expected.to validate_presence_of :user }
    end

    describe 'content' do
      it { is_expected.to validate_presence_of :content }
      it { is_expected.to validate_length_of(:content).is_at_most(500) }
    end
  end

  describe 'associations' do

    it { is_expected.to belong_to :user }
  end
end
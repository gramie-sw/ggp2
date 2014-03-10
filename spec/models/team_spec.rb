describe Team do

  it 'should have valid factory' do
    build(:team).should be_valid
  end

  describe 'validations' do
    describe '#country' do
      it { should validate_presence_of(:country) }
      it { should validate_uniqueness_of(:country) }
    end
  end

  describe 'associations' do
    it { should have_many(:team_1_matches).class_name(:Match).dependent(:restrict_with_exception) }
    it { should have_many(:team_2_matches).class_name(:Match).dependent(:restrict_with_exception) }
    it { should have_many(:champion_tips).dependent(:nullify) }
  end

  describe 'scopes' do
    describe '#order_by_country_name' do
      it 'should order by country name' do
        team_3 = create(:team, country: 'TH')
        team_1 = create(:team, country: 'BM')
        team_2 = create(:team, country: 'MX')

        teams = Team.order_by_country_name
        teams[0].name.should eq team_1.name
        teams[1].name.should eq team_2.name
        teams[2].name.should eq team_3.name
      end
    end
  end
end
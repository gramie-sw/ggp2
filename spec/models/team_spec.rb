describe Team, :type => :model do

  it 'should have valid factory' do
    expect(build(:team)).to be_valid
  end

  describe 'validations' do
    describe '#country' do
      it { is_expected.to validate_presence_of(:country) }
      it { is_expected.to validate_uniqueness_of(:country) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:team_1_matches).class_name(:Match).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:team_2_matches).class_name(:Match).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:champion_tips).dependent(:nullify) }
  end

  describe 'scopes' do
    describe '#order_by_country_name_asc' do
      it 'should order by country name' do
        team_3 = create(:team, country: 'TH')
        team_1 = create(:team, country: 'BM')
        team_2 = create(:team, country: 'MX')

        teams = Team.order_by_country_name_asc
        expect(teams[0].name).to eq team_1.name
        expect(teams[1].name).to eq team_2.name
        expect(teams[2].name).to eq team_3.name
      end
    end
  end
end
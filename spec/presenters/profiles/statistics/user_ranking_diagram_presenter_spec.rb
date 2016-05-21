describe UserRankingDiagramPresenter do

  subject { UserRankingDiagramPresenter.new(user_id, tournament) }

  let(:user_id) { 598 }
  let(:tournament) { Tournament.new }

  total_match_count = 64
  player_count = 53

  before :each do
    allow(tournament).to receive(:total_match_count).and_return(total_match_count)
    allow(tournament).to receive(:player_count).and_return(player_count)
  end

  it { expect(subject.user_id).to be user_id }
  it { expect(subject.tournament).to be tournament }

  describe '#diagram_data' do

    labels = [Match.human_attribute_name(:position), I18n.t('ranking.position')]

    let(:diagram_data_provider) { UserMatchPositionHistoryDataProvider.new(user_id) }

    before :each do
      allow(UserMatchPositionHistoryDataProvider).to receive(:new).with(user_id).and_return(diagram_data_provider)
    end

    it 'returns correct data if played match count is 0' do
      expect(tournament).to receive(:played_match_count).and_return(0)
      expect(subject.diagram_data).to eq [labels, [1, player_count], [total_match_count, player_count]]
    end

    it 'returns correct data if played match count is 1' do
      expect(tournament).to receive(:played_match_count).and_return(1)
      expect(diagram_data_provider).to receive(:provide).and_return([[1, 6]])
      expect(subject.diagram_data).to eq [labels, [0, player_count], [1, 6]]
    end

    it 'returns correct data if played match count is greater 1' do
      expect(tournament).to receive(:played_match_count).and_return(2)
      expect(diagram_data_provider).to receive(:provide).and_return([[1, 6], [2, 8]])
      expect(subject.diagram_data).to eq [labels, [1, 6], [2, 8]]
    end
  end

  describe '#h_axis_min_value' do

    it 'returns 1 if played match count is 0' do
      expect(tournament).to receive(:played_match_count).and_return(0)
      expect(subject.h_axis_min_value).to be 1
    end

    it 'returns 0 if played match count is 1' do
      expect(tournament).to receive(:played_match_count).and_return(1)
      expect(subject.h_axis_min_value).to be 0
    end

    it 'returns 1 if played match count is greater 1' do
      expect(tournament).to receive(:played_match_count).and_return(2)
      expect(subject.h_axis_min_value).to be 1
    end
  end

  describe '#h_axis_max_value' do

    it 'returns total_match_count if played match count is 0' do
      expect(tournament).to receive(:played_match_count).and_return(0)
      expect(subject.h_axis_max_value).to be total_match_count
    end

    it 'returns 1 if played match count is 1' do
      expect(tournament).to receive(:played_match_count).and_return(1)
      expect(subject.h_axis_max_value).to be 1
    end

    it 'returns played_match_count if played match count is greater 1' do
      expect(tournament).to receive(:played_match_count).and_return(2)
      expect(subject.h_axis_max_value).to be 2
    end
  end

  describe '#h_axis_ticks' do

    it 'returns correct ticks array if played match count is 0' do
      expect(tournament).to receive(:played_match_count).and_return(0)
      expect(subject.h_axis_ticks).to eq [1, total_match_count]
    end

    it 'returns correct ticks array if played match count is 1' do
      expect(tournament).to receive(:played_match_count).and_return(1)
      expect(subject.h_axis_ticks).to eq [0, 1]
    end

    it 'returns correct ticks array if played match count is greater 1' do
      expect(tournament).to receive(:played_match_count).and_return(2)
      expect(subject.h_axis_ticks).to eq [1, 2]
    end
  end

  describe '#v_axis_min_value' do

    it 'returns 1' do
      expect(subject.v_axis_min_value).to be 1
    end
  end

  describe '#v_axis_max_value' do

    it 'returns player_count' do
      expect(subject.v_axis_max_value).to be player_count
    end
  end

  describe '#v_axis_ticks' do

    it 'returns correct ticks array' do
      expect(subject.v_axis_ticks).to eq [1, player_count]
    end
  end
end
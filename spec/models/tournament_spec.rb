describe Tournament do

  let(:first_match) { create(:match) }

  subject { Tournament.new }

  before :each do
    relation = double('MatchRelation')
    relation.stub(:first).and_return(first_match)
    Match.stub(:order_by_position).and_return(relation)
  end

  describe '#started?' do

    context 'if matches exists' do

      context 'if first match is started' do

        it 'should return true' do
          first_match.should_receive(:started?).and_return(true)
          subject.should be_started
        end
      end

      context 'if first match is not started' do

        it 'should return false' do
          first_match.should_receive(:started?).and_return(false)
          subject.should_not be_started
        end
      end
    end

    context 'if no match exists' do

      let(:first_match) { nil }

      it 'should return false' do
        subject.should_not be_started
      end
    end
  end

  describe '#start_date' do

    context 'if matches exists' do

      it 'should return the date of the first match' do
        subject.start_date.should eq first_match.date
      end
    end

    context 'if no matches exists' do

      let(:first_match) { nil }

      it 'should return the date of the first match' do
        subject.start_date.should be_nil
      end
    end
  end

  describe '#champion_tip_deadline' do

    it 'should be alias of start_date' do
      subject.method(:champion_tip_deadline).inspect.should match 'start_date'
    end
  end

  describe '#champion_tippable?' do

    context 'if matches exists' do

      context 'if first match is started' do

        it 'should return false' do
          first_match.should_receive(:started?).and_return(true)
          subject.champion_tippable?.should be_false
        end
      end

      context 'if first match is not started' do

        it 'should return false' do
          first_match.should_receive(:started?).and_return(false)
          subject.champion_tippable?.should be_true
        end
      end
    end

    context 'if no match exist' do

      let(:first_match) { nil }

      it 'should return true' do
        subject.champion_tippable?.should be_true
      end
    end
  end

  describe '#played_match_count' do

    it 'should return played match count' do
      relation = double('MatchRelation')
      relation.should_receive(:count).and_return(3)
      Match.should_receive(:only_with_result).and_return(relation)

      subject.played_match_count.should eq 3
    end
  end
end

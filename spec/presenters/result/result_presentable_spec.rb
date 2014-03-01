describe ResultPresentable do

  subject { Object.new.extend(ResultPresentable) }

  describe '#result' do

    context 'if match has result' do

      before :each do
        subject.stub(:score_team_1).and_return(1)
        subject.stub(:score_team_2).and_return(2)
      end

      context 'if hide_existing_result? returns true' do

        it 'should return existing result placeholder' do
          subject.should_receive(:hide_existing_result?).and_return(true)
          subject.result.should eq '* : *'
        end
      end

      context 'if hide_existing_result returns false' do

        it 'should return formatted result' do
          subject.should_receive(:hide_existing_result?).and_return(false)
          subject.result.should eq '1 : 2'
        end
      end
    end

    context 'if match has no result' do

      before :each do
        subject.stub(:score_team_1).and_return(nil)
        subject.stub(:score_team_2).and_return(nil)
      end

      it 'should return formatted result placeholder' do
        subject.result.should eq '- : -'
      end
    end
  end

  describe '#hide_existing_result?' do

    it 'should return false' do
      subject.hide_existing_result?.should be_false
    end
  end
end
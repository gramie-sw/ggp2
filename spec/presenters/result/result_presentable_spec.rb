describe ResultPresentable do

  subject { Object.new.extend(ResultPresentable) }

  describe '#result' do

    context 'if match has result' do

      it 'should return formatted result' do

        subject.stub(:score_team_1).and_return(1)
        subject.stub(:score_team_2).and_return(2)
        subject.result.should eq '1 : 2'
      end
    end

    context 'if match has no result' do

      it 'should return formatted result placeholder' do
        subject.stub(:score_team_1).and_return(nil)
        subject.stub(:score_team_2).and_return(nil)
        subject.result.should eq '- : -'
      end
    end
  end
end
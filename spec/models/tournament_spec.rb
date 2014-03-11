describe Tournament do

  let(:matches) do
    [
        create(:match, position: 3),
        create(:match, position: 1),
        create(:match, position: 2)
    ]
  end

  subject { Tournament.new }

  before :each do
    matches
  end

  describe 'started?' do

    context 'if first match is started?' do

      it 'should return true' do
        #subject.should be_started
      end
    end
  end
end
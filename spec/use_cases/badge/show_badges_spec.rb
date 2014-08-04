describe ShowBadges do

  let(:presenter) { double('presenter') }

  describe '::run' do

    it 'should set presenter with groups and grouped_badges' do

      expect(BadgeRepository).to receive(:badges_sorted_grouped).and_call_original

      expect(presenter).to receive(:groups=) do |groups|
        expect(groups.size).to eq 2
        expect(groups[0]).to eq :comment
        expect(groups[1]).to eq :tip
      end

      expect(presenter).to receive(:grouped_badges=) do |grouped_badges|
        #already tested throughly in BadgeRegistry
        expect(grouped_badges).to be_an_instance_of Hash
        expect(grouped_badges.keys).to include(:comment, :tip)

        actual_comment_badges = grouped_badges[:comment]
        expect(actual_comment_badges.size).to eq 2
        actual_tip_badges = grouped_badges[:tip]
        expect(actual_tip_badges.size).to eq 5
      end

      subject.run presenter
    end
  end
end
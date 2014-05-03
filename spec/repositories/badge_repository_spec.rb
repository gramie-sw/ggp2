describe BadgeRepository do

  describe '::load_grouped_badges' do

    it 'should return a hash loaded from badges_file' do

      load_badges = subject.load_grouped_badges
      expect(load_badges).to be_an_instance_of(Hash)
    end

    it 'should cache load_grouped_badges' do
      expect(subject.load_grouped_badges).to eq subject.load_grouped_badges
    end

    it 'should have symbolized keys' do

      load_grouped_badges = subject.load_grouped_badges

      load_grouped_badges.keys.each do |key|
        expect(key).to be_a(Symbol)

        load_grouped_badges[key].each do |load_badges|
          load_badges.keys.each do |key|
            expect(key).to be_a(Symbol)

            if load_badges[key] == :attributes

              load_badges[key].each do |load_badge|
                load_badge.keys.each do |key|
                  expect(key).to be_a(Symbol)
                end
              end
            end
          end
        end
      end
    end
  end

  describe '::load_groups' do

    it 'should return all badge groups' do

      load_groups = subject.load_groups
      expect(load_groups).to be_an_instance_of(Array)
      expect(load_groups).to eq subject.load_grouped_badges.keys
    end
  end
end
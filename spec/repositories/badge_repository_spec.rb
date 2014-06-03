describe BadgeRepository do

  describe '::grouped_badges' do

    it 'should return a hash loaded from badges_file' do

      actual_grouped_badges = subject.grouped_badges
      expect(actual_grouped_badges).to be_an_instance_of(Hash)
    end

    it 'should cache grouped_badges' do
      expect(subject.grouped_badges).to be subject.grouped_badges
    end

    it 'should have recursive symbolized keys' do

      actual_grouped_badges = subject.grouped_badges

      actual_grouped_badges.keys.each do |key|
        expect(key).to be_a(Symbol)

        actual_grouped_badges[key].each do |load_badges|
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

  describe '::groups' do

    it 'should return all badge groups' do

      actual_groups = subject.groups
      expect(actual_groups).to be_an_instance_of(Array)
      expect(actual_groups).to eq subject.grouped_badges.keys
    end
  end
end
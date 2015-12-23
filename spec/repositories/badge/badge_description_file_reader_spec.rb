describe BadgeDescriptionFileReader do

  describe '#read' do

    it 'returns hash loaded from badges_file' do
      expect(BadgeDescriptionFileReader.read).to be_an_instance_of(Hash)
    end

    it 'caches loaded hash' do
      expect(BadgeDescriptionFileReader.read).to be(subject.read)
    end

    it 'has recursive symbolized keys' do

      actual_grouped_badges = BadgeDescriptionFileReader.read

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
end
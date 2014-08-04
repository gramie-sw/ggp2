describe BadgeFileReader do

  subject { BadgeFileReader.instance}

  describe '#grouped_badges' do

    it 'should return a hash loaded from badges_file' do

      actual_grouped_badges = subject.read
      expect(actual_grouped_badges).to be_an_instance_of(Hash)
    end

    it 'should have recursive symbolized keys' do

      actual_grouped_badges = subject.read

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
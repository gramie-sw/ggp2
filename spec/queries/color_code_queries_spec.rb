describe ColorCodeQueries do

  describe '::all' do

    it 'returns all color codes' do
      actual_color_codes = subject.all

      expect(actual_color_codes.size).to be 4
      expect(actual_color_codes['bronze']).to eq '#cd7f32'
      expect(actual_color_codes['silver']).to eq '#b2b9bc'
      expect(actual_color_codes['gold']).to eq '#d9bb24'
      expect(actual_color_codes['platinum']).to eq '#a67b5b'
    end
  end
end
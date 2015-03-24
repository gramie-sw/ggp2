describe TeamsHelper, :type => :helper do

  describe 'standard_flag_image_tag' do

    context 'when country is nil' do

      it 'should return nil' do
        expect(helper.standard_flag_image_tag(nil)).to be_nil
      end
    end

    context 'when country is present' do

      it 'should return img tag' do
        expect(helper.standard_flag_image_tag('Germany')).to eq "<img class=\"flag flag-germany\" src=\"/assets/blank.gif\" alt=\"Blank\" />"
      end
    end
  end
end
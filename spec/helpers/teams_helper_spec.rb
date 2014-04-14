describe TeamsHelper do

  describe 'standard_flag_image_tag' do

    context 'when country is nil' do

      it 'should return nil' do
        helper.standard_flag_image_tag(nil).should be_nil
      end
    end

    context 'when country is present' do

      it 'should return img tag' do
        helper.standard_flag_image_tag('Germany').should eq "<img alt=\"Blank\" class=\"flag flag-germany\" src=\"/assets/blank.gif\" />"
      end
    end
  end
end
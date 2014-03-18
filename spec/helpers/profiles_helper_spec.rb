describe ProfilesHelper do

  describe '#show_menu_li_attributes' do

    context 'if section equels current_section' do

      it 'should return hash with class active' do
        helper.show_menu_li_attributes(:statistic, :statistic).should eq({class: :active})
      end
    end

    context 'if section does not equel current_section' do

      it 'should return hash with class active' do
        helper.show_menu_li_attributes(:statistic, :not_statistic).should eq({})
      end
    end
  end
end
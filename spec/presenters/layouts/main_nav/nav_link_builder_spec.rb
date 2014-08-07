describe NavLinkBuilder do

  let(:section_registry) { instance_double('SectionRegistry') }
  let(:current_active_markers) { ['marker_1', 'sub_marker_1'] }
  subject { NavLinkBuilder.new(section_registry, *current_active_markers) }

  describe '#build' do

    before :each do
      allow(section_registry).to receive(:is_active?)
    end

    it 'should return NavLink with set label and url' do
      actual_nav_link = subject.build('label_1', 'url_1', :section_1)

      expect(actual_nav_link).to be_instance_of NavLink
      expect(actual_nav_link.label).to eq 'label_1'
      expect(actual_nav_link.url).to eq 'url_1'
    end

    context 'when SectionRegistry declares link as active' do

      it 'should return NavLink where active? is true' do
        expect(section_registry).to receive(:is_active?).with(:section_1, *current_active_markers).and_return(true)

        actual_nav_link = subject.build('label_1', 'url_1', :section_1)
        expect(actual_nav_link).to be_active
      end
    end

    context 'when SectionRegistry declares link as no active' do

      it 'should return NavLink where active? is false' do
        expect(section_registry).to receive(:is_active?).with(:section_1, *current_active_markers).and_return(false)

        actual_nav_link = subject.build('label_1', 'url_1', :section_1)
        expect(actual_nav_link).not_to be_active
      end
    end
  end

end
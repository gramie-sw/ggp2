describe SectionRegistry do

  context 'when section with single 1st level active_marker is configured' do

    let(:section_configuration) do
      SectionConfiguration.new(section: 'section_1', active_markers: 'marker_1')
    end

    before :each do
      subject.register_section(section_configuration)
    end

    context 'when section with correct active marker is asked' do

      it 'should declare section as active' do
        expect(subject.is_active?('section_1', 'marker_1')).to be_true
      end
    end

    context 'when section with correct 1st level but wrong 2nd level active marker is asked' do

      it 'should declare section as active' do
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_2')).to be_true
      end
    end

    context 'when section with wrong active marker is asked' do

      it 'should declare section as not active' do
        expect(subject.is_active?('section_1', 'marker_2')).to be_false
      end
    end

    context 'when wrong section is asked' do

      it 'should declare section as not active' do
        expect(subject.is_active?('section_2', 'marker_1')).to be_false
      end
    end
  end

  context 'when section with single 2nd level active_markers is configured' do

    let(:section_configuration) do
      SectionConfiguration.new(section: 'section_1', active_markers: ['marker_1', 'sub_marker_1'])
    end

    before :each do
      subject.register_section(section_configuration)
    end

    context 'when section with correct 1st and 2nd level active_marker is asked' do

      it 'should declare section as active' do
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_1')).to be_true
      end
    end

    context 'when section with correct 1st and 2nd level but wrong 3rd level active marker is asked' do

      it 'should declare section as active' do
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_1', 'sub_sub_marker_1')).to be_true
      end
    end

    context 'when section with correct 1st but wrong 2nd level active marker is asked' do

      it 'should declare section as not active' do
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_2')).to be_false
      end
    end

    context 'when wrong section is asked' do

      it 'should declare section as not active' do
        expect(subject.is_active?('section_2', 'marker_1', 'sub_marker_1')).to be_false
      end
    end
  end

  context 'when section with multiple 2nd level active_markers is configured' do

    let(:section_configuration) do
      SectionConfiguration.new(section: 'section_1', active_markers: ['marker_1', ['sub_marker_1', 'sub_marker_2']])
    end

    before :each do
      subject.register_section(section_configuration)
    end

    context 'when section with correct 1st and 2nd level active_marker is asked' do

      it 'should declare section as active' do
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_1')).to be_true
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_2')).to be_true
      end
    end

    context 'when section with correct 1st but wrong 2nd level active marker is asked' do

      it 'should declare section as not active' do
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_3')).to be_false
      end
    end

    context 'when wrong section is asked' do

      it 'should declare section as not active' do
        expect(subject.is_active?('section_2', 'marker_1', 'sub_marker_1')).to be_false
      end
    end
  end

  context 'when section with multiple 2nd and 3rd level active_markers is configured' do

    let(:section_configuration) do
      SectionConfiguration.new(
          section: 'section_1', active_markers:
          ['marker_1', ['sub_marker_1', 'sub_marker_2'], ['sub_sub_marker_1', 'sub_sub_marker_2']])
    end

    before :each do
      subject.register_section(section_configuration)
    end

    context 'when section with correct 1st, 2nd, 3rd, level active_marker is asked' do

      it 'should declare section as active' do
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_1', 'sub_sub_marker_1')).to be_true
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_2', 'sub_sub_marker_2')).to be_true
      end
    end

    context 'when section with wrong 3nd level active marker is asked' do

      it 'should declare section as not active' do
        expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_2', 'sub_sub_marker_3')).to be_false
      end
    end

    context 'when wrong section is asked' do

      it 'should declare section as not active' do
        expect(subject.is_active?('section_2', 'marker_1', 'sub_marker_2', 'sub_sub_marker_2')).to be_false
      end
    end
  end

  it 'should accept active marker configuration as symbol' do
    section_configuration = SectionConfiguration.new(
        section: :section_1, active_markers: [:marker_1, [:sub_marker_1, :sub_marker_2]])
    subject.register_section section_configuration
    expect(subject.is_active?('section_1', 'marker_1', 'sub_marker_1')).to be_true
  end

  it 'should accept active section check as symbol' do
    section_configuration = SectionConfiguration.new(
        section: 'section_1', active_markers: ['marker_1', ['sub_marker_1', 'sub_marker_2']])
    subject.register_section section_configuration
    expect(subject.is_active?(:section_1, :marker_1, :sub_marker_1)).to be_true
  end

  it 'should accept nil configuration' do
    subject.register_section SectionConfiguration.new
    expect(subject.is_active?('section_1', 'marker_1')).to be_false
  end

end

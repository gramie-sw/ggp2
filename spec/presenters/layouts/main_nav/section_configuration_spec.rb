describe SectionConfiguration do

  it { should respond_to(:section, :section=) }
  it { should respond_to(:active_markers, :active_markers=) }

  describe '#initialize' do

    it 'should accept name and active_markers' do
      subject = SectionConfiguration.new(section: 'name_1', active_markers: 'active_markers')
      expect(subject.section).to eq 'name_1'
      expect(subject.active_markers).to eq 'active_markers'
    end

    it 'should set name and active_marker to nil be default' do
      subject = SectionConfiguration.new
      expect(subject.section).to be_nil
      expect(subject.active_markers).to be_nil
    end
  end
end
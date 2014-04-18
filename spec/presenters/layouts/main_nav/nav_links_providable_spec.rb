describe NavLinksProvidable do

  let(:subject_class) do
    subject_class = Class.new
    subject_class.send(:include, NavLinksProvidable)
    subject_class
  end
  let(:nav_link_builder) { instance_double('NavLinkBuilder') }
  subject { subject_class.new nav_link_builder }

  it { should respond_to :nav_link_builder }

  describe '::create' do

    it 'should return instance of included class' do
      subject = subject_class.create
      expect(subject).to be_instance_of subject_class
      expect(subject.nav_link_builder).to be_instance_of NavLinkBuilder
    end

    it 'should set instance NavLinkBuilder with SectionRegistry and given current_active_markers' do
      expect(NavLinkBuilder).to receive(:new).with(instance_of(SectionRegistry), [:active_marker_1]).
                                    and_return(:NavLinkBuilder)
      subject = subject_class.create :active_marker_1
      expect(subject.nav_link_builder).to be :NavLinkBuilder
    end

    it 'should accept multiple current_active_markers' do
      expect(NavLinkBuilder).to receive(:new).with(instance_of(SectionRegistry), [:active_marker_1, :active_marker_2]).
                                    and_return(:NavLinkBuilder)
      subject = subject_class.create :active_marker_1, :active_marker_2
    end
  end

  describe '::section' do

    it 'should return SectionConfigurationBuilder with set section' do
      actual_section_configuration_builder = subject_class.section :section_1
      expect(actual_section_configuration_builder).to be_instance_of NavLinksProvidable::SectionConfigurationBuilder
      expect(actual_section_configuration_builder.section).to be :section_1
    end
  end

  describe NavLinksProvidable::SectionConfigurationBuilder do

    subject { NavLinksProvidable::SectionConfigurationBuilder.new(:section_1) }

    describe '#is_active_for' do

      it 'should return SectionConfiguration with set name and active_markers as array' do
        actual_section_configuration = subject.is_active_for :active_marker_1
        expect(actual_section_configuration).to be_instance_of SectionConfiguration
        expect(actual_section_configuration.section).to be :section_1
        expect(actual_section_configuration.active_markers).to eq [:active_marker_1]
      end

      it 'should accept multiple active_markers' do
        actual_section_configuration =
            subject.is_active_for :active_marker_1, :sub_active_marker_2, [:sub_active_marker_3, :sub_active_marker_4]
        expect(actual_section_configuration.active_markers).to eq [
                                                                      :active_marker_1,
                                                                      :sub_active_marker_2,
                                                                      [:sub_active_marker_3, :sub_active_marker_4]
                                                                  ]
      end
    end
  end

  describe '#initialize' do

    it 'should accept instance of NavLinkBuilder' do
      subject = subject_class.new(:NavLinkBuilder)
      expect(subject.nav_link_builder).to be :NavLinkBuilder
    end
  end

  describe '#build_link' do

    it 'should delegate to given NavLinkBuilder instance' do
      nav_link_builder.should_receive(:build).with('label_1', 'url_1', :section_1).and_return(:NavLink)
      expect(subject.build_link('label_1', 'url_1', :section_1)).to be :NavLink
    end
  end
end
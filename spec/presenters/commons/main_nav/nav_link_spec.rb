describe NavLink do

  it { should respond_to(:label, :label=) }
  it { should respond_to(:url, :url=) }
  it { should respond_to(:active?, :active=) }

  describe '#initialize' do

    it 'should provide mass_assignment' do
      subject = NavLink.new(label: 'label_1', url: 'url_1')
      expect(subject.label).to eq 'label_1'
    end
  end
end

describe ActiveSectionConfiguration do

  it { should respond_to(:name, :name=) }
  it { should respond_to(:controller, :controller=) }
  it { should respond_to(:actions) }

  describe '#initialize' do

    it 'should accept name' do
      subject = ActiveSectionConfiguration.new('name_1')
      expect(subject.name).to eq 'name_1'
    end
  end
end
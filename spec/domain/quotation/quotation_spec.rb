describe Quotation do

  it { is_expected.to respond_to(:author=, :author) }
  it { is_expected.to respond_to(:content=, :content) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      subject = Quotation.new(author: 'author_1', content: 'content')
      subject.author = 'author_1'
      subject.content = 'content_1'
    end
  end
end
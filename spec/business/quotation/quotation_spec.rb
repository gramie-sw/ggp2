describe Quotation do

  it { should respond_to(:author=, :author) }
  it { should respond_to(:content=, :content) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      subject = Quotation.new(author: 'author_1', content: 'content')
      subject.author = 'author_1'
      subject.content = 'content_1'
    end
  end
end
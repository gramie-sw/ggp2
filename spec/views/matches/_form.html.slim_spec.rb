describe 'matches/_form.html.slim.rb' do

  let(:partial) do
    {
        partial: 'matches/form',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            match: match
        }
    }
  end

  let(:match) {Match.new(aggregate: Aggregate.new(id: 676))}

  before :each do
    allow(view).to receive(:legend)
  end

  describe 'subsequent checkbox' do

    subsequent_match_checkbox_css = 'input[type=checkbox][name=subsequent_match]'

    it 'is displayed if match is new' do
      render partial
      expect(rendered).to have_css(subsequent_match_checkbox_css)
    end

    it 'is not displayed if match is not new' do
      match.id = 765
      allow(match).to receive(:new_record?).and_return(false)
      render partial
      expect(rendered).not_to have_css(subsequent_match_checkbox_css)
    end

    it 'is checked when subsequent_match is present' do
      allow(view).to receive(:params).and_return({subsequent_match: '1'})
      render partial
      expect(rendered).to have_css("#{subsequent_match_checkbox_css}[checked=checked]")
    end
  end
end
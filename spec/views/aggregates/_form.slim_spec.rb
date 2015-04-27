describe 'aggregates/_form.html.slim.rb' do

  let(:partial) do
    {
        partial: 'aggregates/form',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            presenter: presenter,
            legend: 'legend'

        }
    }
  end

  let(:aggregate) { Aggregate.new }
  let(:presenter) { AggregateFormPresenter.new(aggregate)}

  describe 'phase field' do

    phase_field_css = 'input[name=phase_name]'

    context 'if aggregate is a phase' do

      it 'is not displayed' do
        render partial
        expect(rendered).not_to have_css(phase_field_css)
      end
    end

    context 'if aggregate is a group' do

      before :each do
        allow(aggregate).to receive(:group?).and_return(true)
        allow(aggregate).to receive(:parent).and_return(Aggregate.new)
      end

      it 'is not displayed' do
        render partial
        expect(rendered).to have_css(phase_field_css)
      end
    end
  end

  describe 'subsequent checkbox' do

    subsequent_aggregate_checkbox_css = 'input[type=checkbox][name=subsequent_aggregate]'

    it 'is displayed if aggregate is new' do
      render partial
      expect(rendered).to have_css(subsequent_aggregate_checkbox_css)
    end

    it 'is not displayed if aggregate is not new' do
      aggregate.id = 765
      allow(aggregate).to receive(:new_record?).and_return(false)
      render partial
      expect(rendered).not_to have_css(subsequent_aggregate_checkbox_css)
    end

    it 'is checked when subsequent_aggregate is present' do
      allow(view).to receive(:params).and_return({subsequent_aggregate: '1'})
      render partial
      expect(rendered).to have_css("#{subsequent_aggregate_checkbox_css}[checked=checked]")
    end
  end

end
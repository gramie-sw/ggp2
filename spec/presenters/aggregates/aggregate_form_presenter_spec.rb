describe AggregateFormPresenter do

  let(:aggregate) { Aggregate.new(id: 12) }
  
  subject { AggregateFormPresenter.new(aggregate) }

  it { is_expected.to respond_to(:aggregate)}

  describe '#model_translation' do

    context 'is aggregate is an phase' do

      it 'returns model_translation for phase' do
        expect(subject.model_translation).to eq t('general.phase.one')
        expect(subject.model_translation(plural: true)).to eq t('general.phase.other')
      end
    end

    context 'is aggregate is a group' do

      before :each do
        allow(aggregate).to receive(:phase?).and_return(false)
      end

      it 'returns model_translation for group' do
        expect(subject.model_translation).to eq t('general.group.one')
        expect(subject.model_translation(plural: true)).to eq t('general.group.other')
      end
    end
  end
end
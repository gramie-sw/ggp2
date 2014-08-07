describe RecordBatchUpdatable, :type => :model do

  subject { Object.new.extend(RecordBatchUpdatable) }

  let(:models) do
    [
        double('Model', errors: double(empty?: true)),
        double('Model', errors: double(empty?: true)),
        double('Model', errors: double(empty?: true))
    ]
  end

  let(:models_attributes) { {1 => :attributes_1, 2 => :attributes_2, 3 => :attributes_3, } }

  before :each do
    allow(subject).to receive(:update).and_return(models)
    allow(models_attributes).to receive(:permitted?).and_return(true)
  end

  describe '#update_multiple' do

    it 'should call #update' do
      expect(subject).to receive(:update).with(models_attributes.keys, models_attributes.values).and_return(models)
      subject.update_multiple(models_attributes)
    end

    it 'should return BatchUpdater::Result' do
      expect(subject.update_multiple(models_attributes)).to be_kind_of RecordBatchUpdatable::Result
    end

    context 'when all models could be saved' do

      it 'should return result where #no_errors? is true' do
        expect(subject.update_multiple(models_attributes).no_errors?).to be_truthy
      end

      it 'should return result where #succeeded_records contains all models' do
        succeeded_records = subject.update_multiple(models_attributes).succeeded_records
        expect(succeeded_records.count).to eq 3
        expect(succeeded_records).to include *models
      end

      it 'should return result where #failed_records is empty' do
        expect(subject.update_multiple(models_attributes).failed_records).to be_empty
      end
    end

    context 'when all models could be saved' do

      before :each do
        allow(models.first).to receive(:errors).and_return(double(empty?: false))
        allow(models.third).to receive(:errors).and_return(double(empty?: false))
      end

      it 'should return result where #no_errors? is false' do
        expect(subject.update_multiple(models_attributes).no_errors?).to be_falsey
      end

      it 'should return result where #succeded_models all updated models' do
        succeeded_records = subject.update_multiple(models_attributes).succeeded_records
        expect(succeeded_records.count).to eq 1
        expect(succeeded_records).to include models.second
      end

      it 'should return result where #failed_records contains all failed models' do
        failed_records = subject.update_multiple(models_attributes).failed_records
        expect(failed_records.count).to eq 2
        expect(failed_records).to include models.first, models.last
      end
    end
  end

  context 'when model_attributes are not permitted' do

    it 'should raise ActiveModel::ForbiddenAttributesError' do
      expect(models_attributes).to receive(:permitted?).and_return(false)
      expect(subject).not_to receive(:update)
      expect{subject.update_multiple(models_attributes)}.to raise_error ActiveModel::ForbiddenAttributesError
    end
  end
end
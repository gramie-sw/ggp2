describe RecordBatchUpdatable do

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
    subject.stub(:update).and_return(models)
  end

  describe '#update_multiple' do

    it 'should call #update' do
      subject.should_receive(:update).with(models_attributes.keys, models_attributes.values).and_return(models)
      subject.update_multiple(models_attributes)
    end

    it 'should return BatchUpdater::Result' do
      subject.update_multiple(models_attributes).should be_kind_of RecordBatchUpdatable::Result
    end

    context 'if all models could be saved' do

      it 'should return result where #no_errors? is true' do
        subject.update_multiple(models_attributes).no_errors?.should be_true
      end

      it 'should return result where #succeeded_records contains all models' do
        succeeded_records = subject.update_multiple(models_attributes).succeeded_records
        succeeded_records.count.should eq 3
        succeeded_records.should include *models
      end

      it 'should return result where #failed_records is empty' do
        subject.update_multiple(models_attributes).failed_records.should be_empty
      end
    end

    context 'if all models could be saved' do

      before :each do
        models.first.stub(:errors).and_return(double(empty?: false))
        models.third.stub(:errors).and_return(double(empty?: false))
      end

      it 'should return result where #no_errors? is false' do
        subject.update_multiple(models_attributes).no_errors?.should be_false
      end

      it 'should return result where #succeded_models all updated models' do
        succeeded_records = subject.update_multiple(models_attributes).succeeded_records
        succeeded_records.count.should eq 1
        succeeded_records.should include models.second
      end

      it 'should return result where #failed_records contains all failed models' do
        failed_records = subject.update_multiple(models_attributes).failed_records
        failed_records.count.should eq 2
        failed_records.should include models.first, models.last
      end
    end
  end

end
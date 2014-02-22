describe ModelBatchUpdatable do

  subject { Object.new.extend(ModelBatchUpdatable) }

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
      subject.update_multiple(models_attributes).should be_kind_of ModelBatchUpdatable::Result
    end

    context 'if all models could be saved' do

      it 'should return result where #error_occurred? is false' do
        subject.update_multiple(models_attributes).errors_occurred?.should be_false
      end

      it 'should return result where #succeeded_models contains all models' do
        succeeded_models = subject.update_multiple(models_attributes).succeeded_models
        succeeded_models.count.should eq 3
        succeeded_models.should include *models
      end

      it 'should return result where #failed_models is empty' do
        subject.update_multiple(models_attributes).failed_models.should be_empty
      end
    end

    context 'if all models could be saved' do

      before :each do
        models.first.stub(:errors).and_return(double(empty?: false))
        models.third.stub(:errors).and_return(double(empty?: false))
      end

      it 'should return result where #errors_occurred? is true' do
        subject.update_multiple(models_attributes).errors_occurred?.should be_true
      end

      it 'should return result where #succeded_models all updated models' do
        succeeded_models = subject.update_multiple(models_attributes).succeeded_models
        succeeded_models.count.should eq 1
        succeeded_models.should include models.second
      end

      it 'should return result where #failed_models contains all failed models' do
        failed_models = subject.update_multiple(models_attributes).failed_models
        failed_models.count.should eq 2
        failed_models.should include models.first, models.last
      end
    end
  end

end
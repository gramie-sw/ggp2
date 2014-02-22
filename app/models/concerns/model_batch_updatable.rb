module ModelBatchUpdatable

  Result = Struct.new(:errors_occurred?, :succeeded_models, :failed_models)

  def update_multiple models_attributes
    models = self.update(models_attributes.keys, models_attributes.values)

    succeeded_models, failed_models = [], []
    models.each do |model|
      if model.errors.empty?
        succeeded_models << model
      else
        failed_models << model
      end
    end

    Result.new(failed_models.present?, succeeded_models, failed_models)
  end
end
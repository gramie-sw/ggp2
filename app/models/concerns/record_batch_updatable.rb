module RecordBatchUpdatable

  Result = Struct.new(:no_errors, :succeeded_records, :failed_records) do
    alias :no_errors? :no_errors
  end

  #TODO change name of this method because it does not store transactional
  def update_multiple models_attributes
    raise ActiveModel::ForbiddenAttributesError unless models_attributes.permitted?
    models = self.update(models_attributes.keys, models_attributes.values)

    succeeded_records, failed_records = [], []
    models.each do |model|
      if model.errors.empty?
        succeeded_records << model
      else
        failed_records << model
      end
    end

    Result.new(failed_records.empty?, succeeded_records, failed_records)
  end
end
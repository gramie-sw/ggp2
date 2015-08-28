class ActiveRecord::Base

  class << self

    def create_unvalidated(attributes={})
      record = self.new(attributes)
      record.save(validate: false)
      record
    end
  end
end
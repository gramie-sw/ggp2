class Property < ActiveRecord::Base

  LAST_RESULT_MATCH_ID = 'last_result_match_id'

  validates :key, presence: true, uniqueness: true, length: {maximum: 64}
  validates :value, presence: true, length: {maximum: 128}

  def self.save_last_result_match_id match_id
    property = Property.find_or_create_by(key: LAST_RESULT_MATCH_ID)
    property.update_attribute :value, match_id
  end
end

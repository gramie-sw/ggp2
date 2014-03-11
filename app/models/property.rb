class Property < ActiveRecord::Base

  LAST_RESULT_MATCH_ID = 'last_result_match_id'

  validates :key, presence: true, uniqueness: true, length: {maximum: 64}
  validates :value, presence: true, length: {maximum: 128}
end

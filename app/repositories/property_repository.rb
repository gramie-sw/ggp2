module PropertyRepository

  def save_value(key, value)
    Property.find_or_create_by(key: key).update_attribute(:value, value)
  end

  def find_value(key)
    Property.find_by_key(key).try(:value)
  end
end
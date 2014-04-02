module UserFactory
  extend self

  def build user_attributes
    User.new(user_attributes)
  end
end
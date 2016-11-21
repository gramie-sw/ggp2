class TeamSerializer < ActiveModel::Serializer
  attribute :name
  attribute :code do
    object.team_code
  end
end
class SetTeamTypeProperty < ActiveRecord::Migration

  def up
    PropertyQueries.save_value(Property::TEAM_TYPE_KEY, Team::TYPES.first)
  end

  def down
    PropertyQueries.delete(Property::TEAM_TYPE_KEY)
  end
end

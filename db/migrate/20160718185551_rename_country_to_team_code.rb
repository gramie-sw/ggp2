class RenameCountryToTeamCode < ActiveRecord::Migration
  def change
    rename_column :teams, :country, :team_code
  end
end

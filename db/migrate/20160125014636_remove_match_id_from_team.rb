class RemoveMatchIdFromTeam < ActiveRecord::Migration
  def change
    remove_column(:teams, :match_id)
  end
end

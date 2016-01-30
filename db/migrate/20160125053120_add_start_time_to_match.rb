class AddStartTimeToMatch < ActiveRecord::Migration
  def change
    add_column(:matches, :start_hour, :integer, null: false)
  end
end

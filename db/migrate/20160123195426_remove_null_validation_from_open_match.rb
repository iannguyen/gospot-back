class RemoveNullValidationFromOpenMatch < ActiveRecord::Migration
  def change
    remove_column(:matches, :open)
    add_column(:matches, :open, :boolean, default: false)
  end
end

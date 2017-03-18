class AddColumnToDrills < ActiveRecord::Migration[5.0]
  def change
    add_column :drills, :completed, :integer
  end
end

class AddGroupToDrills < ActiveRecord::Migration[5.0]
  def change
    add_reference :drills, :group, foreign_key: true
  end
end

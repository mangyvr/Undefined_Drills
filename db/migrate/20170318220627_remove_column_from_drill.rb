class RemoveColumnFromDrill < ActiveRecord::Migration[5.0]
  def change
    remove_column :drills, :completed
  end
end

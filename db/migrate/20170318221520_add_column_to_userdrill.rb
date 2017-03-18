class AddColumnToUserdrill < ActiveRecord::Migration[5.0]
  def change
    add_column :user_drills, :completed, :boolean
  end
end

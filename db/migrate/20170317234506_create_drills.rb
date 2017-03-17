class CreateDrills < ActiveRecord::Migration[5.0]
  def change
    create_table :drills do |t|
      t.string :title
      t.text :description
      t.integer :level
      t.integer :points

      t.timestamps
    end
  end
end

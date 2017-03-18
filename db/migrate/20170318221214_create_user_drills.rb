class CreateUserDrills < ActiveRecord::Migration[5.0]
  def change
    create_table :user_drills do |t|
      t.references :user, foreign_key: true
      t.references :drill, foreign_key: true

      t.timestamps
    end
  end
end

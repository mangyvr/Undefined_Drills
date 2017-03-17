class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :is_admin
      t.string :password_digest
      t.boolean :is_validated
      t.integer :score
      t.string :token_field

      t.timestamps
    end
  end
end

class AddUserIdReferencesColumnToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :user_id, :integer
    add_foreign_key :answers, :users
  end
end

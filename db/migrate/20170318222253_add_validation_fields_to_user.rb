class AddValidationFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :valid_email, :boolean, default: false
    add_column :users, :email_validation_token, :string
    add_column :users, :email_validation_sent_at, :datetime
  end
end

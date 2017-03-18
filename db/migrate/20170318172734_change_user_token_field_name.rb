class ChangeUserTokenFieldName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :token_field, :password_reset_token
  end
end

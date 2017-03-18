class AddAttemptToUserdrill < ActiveRecord::Migration[5.0]
  def change
    add_column :user_drills, :attempts, :integer
  end
end

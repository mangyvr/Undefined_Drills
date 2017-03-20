class AddHintColumnToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :hint, :string, default: 'No hint for you'
  end
end

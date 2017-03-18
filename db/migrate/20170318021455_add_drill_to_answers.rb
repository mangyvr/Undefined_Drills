class AddDrillToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_reference :answers, :drill, foreign_key: true
  end
end

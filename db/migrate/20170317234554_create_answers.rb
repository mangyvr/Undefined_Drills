class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.boolean :approved

      t.timestamps
    end
  end
end

class AddDummyDataToUserdrill < ActiveRecord::Migration[5.0]
  def change
    5.times do
      UserDrill.create(user_id: Faker::Number.between(1,10), drill_id: Faker::Number.between(1,5), completed: true, attempts: Faker::Number.between(1,20))
    end
  end
end

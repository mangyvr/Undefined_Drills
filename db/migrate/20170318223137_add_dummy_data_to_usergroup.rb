class AddDummyDataToUsergroup < ActiveRecord::Migration[5.0]
  def change
    10.times do
      UserGroup.create(user_id: Faker::Number.between(1,10), group_id: Faker::Number.between(1,5))
    end
  end
end

class AddDummyDataToGroup < ActiveRecord::Migration[5.0]
  def change
    5.times do
      Group.create(title: Faker::Hacker.noun)
    end
  end
end

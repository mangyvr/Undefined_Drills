class AddDummyDataToDrill < ActiveRecord::Migration[5.0]
  def change
    5.times do
      Drill.create(title: Faker::Pokemon.name, description: Faker::Lorem.paragraph(5))
    end
  end
end

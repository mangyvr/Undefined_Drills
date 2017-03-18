class AddDummyDataToUser < ActiveRecord::Migration[5.0]
  def change
    10.times do
      User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password_digest: 'a')
    end
  end
end

10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password_digest: 'a')
end

5.times do
  Drill.create(title: Faker::Pokemon.name, description: Faker::Lorem.paragraph(5), group_id: 1, user_id: 1)
end


5.times do
  Group.create(title: Faker::Hacker.noun)
end

5.times do
  Answer.create(body: Faker::Hipster.paragraph, drill_id: 1)
end

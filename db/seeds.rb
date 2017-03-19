10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'a', score: 0)
end

5.times do
  Group.create(title: Faker::Pokemon.name)
end

groups = Group.all


20.times do
  Drill.create(title: Faker::Hacker.say_something_smart, description: Faker::Hipster.sentence, level: rand(2), points: rand(500), group: groups.sample)
end

drills = Drill.all

60.times do
  Answer.create(body: Faker::Pokemon.name, approved: true, drill: drills.sample)
end

10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'a', score: 0, valid_email: true, is_validated: true)
end

User.first.update(is_admin: true, score: 1)

users = User.all

6.times do
  Group.create(title: Faker::Pokemon.name)
end

groups = Group.all

20.times do
  Drill.create(title: Faker::Hacker.say_something_smart, description: Faker::Hipster.sentence, level: (rand(3)+1).ceil, points: rand(500).ceil, group: groups.sample)
end

drills = Drill.all

60.times do
  Answer.create(body: Faker::Pokemon.name, approved: true, drill: drills.sample)
end

30.times do
  UserDrill.create(user: users.sample, drill: drills.sample, completed: true, attempts: (rand(10)+1).ceil)
end

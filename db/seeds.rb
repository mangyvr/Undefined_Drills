10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'a', score: rand(500).ceil, valid_email: true, is_validated: true)
end

User.first.update(is_admin: true, score: 1000)

admin = User.first

Group.create(title: 'Pokemon')
drillrand = (rand(8)+3).ceil
drillrand.times do
  location = Faker::Pokemon.location
  level = (rand(3)+1).ceil
  points = level * 150 + rand(5).ceil * 10
  Drill.create(title: location, description: "Which Pokemon can be found near #{location}?", level: level, points: points, group: Group.last)
  thisdrill = Drill.last
  ansrand = (rand(2)+1).ceil
  ansrand.times do
    Answer.create(drill: thisdrill, body: Faker::Pokemon.name, approved: true, user: admin)
  end
end

Group.create(title: 'Superheroes')
drillrand = (rand(8)+3).ceil
drillrand.times do
  hero = Faker::Superhero.name
  level = (rand(3)+1).ceil
  points = level * 150 + rand(5).ceil * 10
  Drill.create(title: hero, description: "What is #{hero}'s superpower?", level: level, points: points, group: Group.last)
  thisdrill = Drill.last
  ansrand = (rand(2)+1).ceil
  ansrand.times do
    Answer.create(drill: thisdrill, body: Faker::Superhero.power, approved: true, user: admin)
  end
end

Group.create(title: 'Star Wars')
drillrand = (rand(8)+3).ceil
drillrand.times do
  hero = Faker::StarWars.character
  level = (rand(3)+1).ceil
  points = level * 150 + rand(5).ceil * 10
  Drill.create(title: hero, description: "What species is #{hero}?", level: level, points: points, group: Group.last)
  thisdrill = Drill.last
  ansrand = (rand(2)+1).ceil
  ansrand.times do
    Answer.create(drill: thisdrill, body: Faker::StarWars.specie, approved: true, user: admin)
  end
end

Group.create(title: 'Potterverse')
drillrand = (rand(8)+3).ceil
drillrand.times do
  hero = Faker::HarryPotter.character
  level = (rand(3)+1).ceil
  points = level * 150 + rand(5).ceil * 10
  Drill.create(title: hero, description: "What is one of #{hero}'s favorite places?", level: level, points: points, group: Group.last)
  thisdrill = Drill.last
  ansrand = (rand(2)+1).ceil
  ansrand.times do
    Answer.create(drill: thisdrill, body: Faker::HarryPotter.location, approved: true, user: admin)
  end
end

Group.create(title: 'GoT')
drillrand = (rand(8)+3).ceil
drillrand.times do
  house = Faker::GameOfThrones.house
  level = (rand(3)+1).ceil
  points = level * 150 + rand(5).ceil * 10
  Drill.create(title: "House #{house}", description: "Which character belongs to house #{house}?", level: level, points: points, group: Group.last)
  thisdrill = Drill.last
  ansrand = (rand(2)+1).ceil
  ansrand.times do
    Answer.create(drill: thisdrill, body: Faker::GameOfThrones.character, approved: true, user: admin)
  end
end

Group.create(title: 'LotR')
drillrand = (rand(8)+3).ceil
drillrand.times do
  location = Faker::LordOfTheRings.location
  level = (rand(3)+1).ceil
  points = level * 150 + rand(5).ceil * 10
  Drill.create(title: location, description: "Which character hails from #{location}?", level: level, points: points, group: Group.last)
  thisdrill = Drill.last
  ansrand = (rand(2)+1).ceil
  ansrand.times do
    Answer.create(drill: thisdrill, body: Faker::LordOfTheRings.character, approved: true, user: admin)
  end
end


users = User.all
groups = Group.all
drills = Drill.all



40.times do
  UserDrill.create(user: users.sample, drill: drills.sample, completed: Faker::Boolean.boolean, attempts: (rand(5)+1).ceil)
end

15.times do
  UserGroup.create(user: users.sample, group: groups.sample)
end

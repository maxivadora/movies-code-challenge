20.times do |i|
  p "Person #{i}"
  Person.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    aliases: Faker::FunnyName.name
  )
  p "Movie #{i}"
  Movie.create(
    title: Faker::Movie.quote,
    release_year: Faker::Number.between(1950, 2018)
  )
end

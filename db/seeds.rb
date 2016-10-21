User.create! name:  "Trainee", email: "trainee@gmail.com", password: "123456",
  password_confirmation: "123456", role: 0
User.create! name: "Supervisor", email: "supervisor@gmail.com",
  password: "123456", password_confirmation: "123456", role: 1
User.create! name: "Admin", email: "admin@gmail.com", password: "123456",
  password_confirmation: "123456", role: 2

50.times do
  name = Faker::Name.title
  description = Faker::Hacker.say_something_smart
  start_date = "2016-10-17"
  end_date = "2016-12-17"
  Course.create name: name, description: description, start_date: start_date,
    end_date: end_date
end

10.times do |n|
  name  = Faker::Name.name
  email = "trainee#{n+1}@gmail.com"
  password = "123456"
  User.create!(name:  name, email: email, password: password,
    password_confirmation: password, role: 0)
end

5.times do |n|
  name  = Faker::Name.name
  email = "supervisor#{n+1}@gmail.com"
  password = "123456"
  User.create!(name:  name, email: email, password: password,
    password_confirmation: password, role: 1)
end

3.times do |n|
  name  = Faker::Name.name
  email = "admin#{n+1}@gmail.com"
  password = "123456"
  User.create!(name:  name, email: email, password: password,
    password_confirmation: password, role: 2)
end

20.times do |s|
  name = "Subject#{s+1}"
  description = Faker::Lorem.sentence
  introducs = "Get it overview task in here"
  Subject.create! name: name, description: description,
  tasks_attributes: [
    {name:"Task 1", description: introducs},
    {name:"Task 2", description: introducs},
    {name:"Task 3", description: introducs},
    {name:"Task 4", description: introducs}]
end

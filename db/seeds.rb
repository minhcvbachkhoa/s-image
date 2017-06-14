# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create! name: "Example Name", email: "test@gmail.com",
  password: "foobar", password_confirmation: "foobar"

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end

User.create! name: "Cao Văn Minh", email: "minhcv@gmail.com",
  password: "minhcv", password_confirmation: "minhcv", admin: true

User.create! name: "Nguyễn Thế Phương", email: "phuongnt@gmail.com",
  password: "phuongnt", password_confirmation: "phuongnt", admin: true

users = User.all
users.limit(20).each do |user|
  name = Faker::Team.name
  policy = Faker::Number.between(0, 1)
  Group.create! name: name, policy: policy
  GroupUser.create! group_id: Group.last.id, user_id: user.id,
    admin_group: true
  1.upto(5) do |n|
    GroupUser.create! group_id: Group.last.id, user_id: user.id+n
  end
end

user = users.first
following = users[2..20]
followers = users[3..25]
following.each {|followed| user.follow followed}
followers.each {|follower| follower.follow user}

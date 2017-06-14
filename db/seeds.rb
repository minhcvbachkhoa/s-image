User.create! name: "Example Name", email: "test@gmail.com",
  password: "foobar", password_confirmation: "foobar"

User.create! name: "Cao Văn Minh", email: "minhcv@gmail.com",
  password: "minhcv", password_confirmation: "minhcv", admin: "admin"

User.create! name: "Nguyễn Thế Phương", email: "phuongnt@gmail.com",
  password: "phuongnt", password_confirmation: "phuongnt", admin: "admin"

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end

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

Category.create!([{name: "Ảnh phong cảnh"}, {name: "Ảnh chân dung"},
  {name: "Ảnh di sản văn hóa"}, {name: "Ảnh kiến trúc"},
  {name: "Ảnh sinh hoạt"}, {name: "Ảnh tĩnh vật"},
  {name: "Ảnh thể thao" }, {name: "Ảnh động vật"}])

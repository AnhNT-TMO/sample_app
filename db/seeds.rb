# Create a main sample user.
User.create!(name: "Example User",

  email: "example@railstutorial.org",
  password: "123456",
  password_confirmation: "123456",
  admin: true)
# Generate a bunch of additional users.
99.times do |n|
  name = "User: #{n+1}"
  email = "example-#{n+1}@railstutorial.org";
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end

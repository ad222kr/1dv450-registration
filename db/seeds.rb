# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "Admin Svensson", email:"admin@admin.com", password: "adminpassword",
            password_confirmation: "adminpassword", admin: true)
@testuser = User.create(name: "Test User", email:"testuser@example.com", password: "testuserpassword",
            password_confirmation: "testuserpassword")

@testuser.apps << App.create(name: "TestApp", api_key: "justATestApiKeyOne")
@testuser.apps << App.create(name: "TestApp2", api_key: "justATestApiKeyTwoLol")
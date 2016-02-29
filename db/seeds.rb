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

@testuser2 = User.create(name: "Test Usah!!", email: "testuser2@example.com", password: "testuser2password",
                         password_confirmation: "testuser2password")



@testuser.apps.create(name: "TestApp", api_key: "justATestApiKeyOne")
@testuser.apps.create(name: "TestApp2", api_key: "justATestApiKeyTwoLol")

@testuser2.apps.create(name: "Twittah!", api_key: "thwittahLOLOLOLOLOL")
@testuser2.apps.create(name: "Faceboookah", api_key: "facebokahYOYOYO")

Pub.create(name: "Sverres pub")


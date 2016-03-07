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



@testuser.apps << App.create(name: "TestApp", api_key: "justATestApiKeyOne")
@testuser2.apps << App.create(name: "TestApp2", api_key: "justATestApiKeyTwoLol")


@pub = Pub.create(name: "Sverres pub", phone_number: "0202002123", description: "asdasdasdasd")
@pub2 = Pub.create(name: "Alex pub", phone_number: "0202002444", description: "asdasdasdasd")
@pub3 = Pub.create(name: "Mattias pub", phone_number: "020200442", description: "asdasdasdasd")
@pub4 = Pub.create(name: "Jossans pub", phone_number: "020200222", description: "asdasdasdasd")
@pub5 = Pub.create(name: "Nalles pub", phone_number: "0202055502", description: "asdasdasdasd")

@creator1 = Creator.create(email: "testcreator@example.com", password: "testcreatorpassword")
@creator2 = Creator.create(email: "testcreator2@example.com", password: "testcreatorpassword")


@pub.creator = @creator1
@pub2.creator = @creator2
@pub3.creator = @creator1
@pub4.creator = @creator2
@pub5.creator = @creator1


@pub.position = Position.create(address: "Skräddaretorpsvägen 14, Kalmar")
@pub2.position = Position.create(address: "Gröndalsvägen 27, Kalmar")
@pub3.position = Position.create(address: "Skräddaretorpsvägen 6, Kalmar")
@pub4.position = Position.create(address: "Södra Långgatan 6, Kalmar")
@pub5.position = Position.create(address: "Skräddaretorpsvägen 10, Kalmar")

@tag = Tag.create(name: "Skön stämning!")
@tag2 = Tag.create(name: "Skitdålig")
@tag3 = Tag.create(name: "Mysig!")

@pub.tags << @tag
@pub.tags << @tag3

@pub2.tags << @tag2

@pub3.tags << @tag

@pub4.tags << @tag3

@pub5.tags << @tag
@pub5.tags << @tag2
@pub5.tags << @tag3


@pub.save
@pub2.save
@pub3.save
@pub4.save
@pub5.save






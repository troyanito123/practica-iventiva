# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create!(name: 'Administrator', code: 'ADMIN')
Role.create!(name: 'User', code: 'USER')

User.create!(name:  "Admin User",
             email: "admin@test.com",
             password:              "123123",
             password_confirmation: "123123",
             role_id:     1,
             activated: true,
             activated_at: Time.zone.now)
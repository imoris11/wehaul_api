# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([{name:'Eniola Roland', email: 'user@benuetv.ng', role:'admin', password: 'Password', password_confirmation: 'Password', profile_picture: Faker::Avatar.image}, {name:'Richard Igbiriki', email: 'test@benuetv.ng', role:'admin', password: 'Password', password_confirmation: 'Password', profile_picture: Faker::Avatar.image} ])
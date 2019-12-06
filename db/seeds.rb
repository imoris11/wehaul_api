# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([{name:'Eniola Roland', email: 'user@benuetv.ng', role:'admin', password: 'Password', password_confirmation: 'Password', profile_picture: Faker::Avatar.image}, {name:'Richard Igbiriki', email: 'test@benuetv.ng', role:'admin', password: 'Password', password_confirmation: 'Password', profile_picture: Faker::Avatar.image} ])
categories = Category.create([{ title: 'Politics' }, {title: 'Sports'}, {title: 'Entertainment'}, {title: 'Religion'} ])
# users.each do |user|
#     puts "Creating for #{user.name}"
#     #Create articles
#     5.times do |i|
#         user.articles.create(title:  Faker::Lorem.sentence, content: Faker::Lorem.paragraph, category_id: categories.first.id, views:0, header_photo: Faker::Avatar.image, photo_caption: Faker::Lorem.sentence )
#     end
#     5.times do |i|
#         user.articles.create(title:  Faker::Lorem.sentence, content: Faker::Lorem.paragraph, category_id: categories.second.id, views:0, header_photo: Faker::Avatar.image, photo_caption: Faker::Lorem.sentence)
#     end
#     5.times do |i|
#         user.articles.create(title:  Faker::Lorem.sentence, content: Faker::Lorem.paragraph, category_id: categories.third.id, views:0, header_photo: Faker::Avatar.image, photo_caption: Faker::Lorem.sentence)
#     end
#     5.times do |i|
#         user.articles.create(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, category_id: categories.fourth.id, views:0, header_photo: Faker::Avatar.image, photo_caption: Faker::Lorem.sentence)
#     end
#     5.times do |i|
#         user.articles.create(title:  Faker::Lorem.sentence, content: Faker::Lorem.paragraph, category_id: categories.fourth.id, views:0, header_photo: Faker::Avatar.image, photo_caption: Faker::Lorem.sentence)
#     end

#     #Create videos 
#     5.times do |i|
#         user.videos.create(title:  Faker::Lorem.sentence, category_id: categories.first.id, views:0, video_url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', header_photo: Faker::Avatar.image)
#     end
#     5.times do |i|
#         user.videos.create(title:  Faker::Lorem.sentence, category_id: categories.second.id, views:0, video_url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', header_photo: Faker::Avatar.image)
#     end
#     5.times do |i|
#         user.videos.create(title:  Faker::Lorem.sentence, category_id: categories.third.id, views:0, video_url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', header_photo: Faker::Avatar.image)
#     end
#     5.times do |i|
#         user.videos.create(title: Faker::Lorem.sentence, category_id: categories.fourth.id, views:0, video_url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', header_photo: Faker::Avatar.image)
#     end
#     5.times do |i|
#         user.videos.create(title:  Faker::Lorem.sentence, category_id: categories.fourth.id, views:0, video_url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', header_photo: Faker::Avatar.image)
#     end
# end

# user = users.first

# 5.times do |i|
#     user.schedules.create(title: Faker::Lorem.sentence, header_photo: Faker::Avatar.image, date_time: Time.now + i.hours )
# end

# 5.times do |i|
#     user.schedules.create(title: Faker::Lorem.sentence, header_photo: Faker::Avatar.image, date_time: Time.now + i.hours + 1.days )
# end

# 5.times do |i|
#     user.schedules.create(title: Faker::Lorem.sentence, header_photo: Faker::Avatar.image, date_time: Time.now + i.hours + 2.days )
# end
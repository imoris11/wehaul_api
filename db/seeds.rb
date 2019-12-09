users = User.create([{name:'Eniola Roland', email: 'user@wehaul.ng', role:'Super Admin', admin: true, password: 'Password', password_confirmation: 'Password', phone_number: '080323423422'}, {name:'Richard Igbiriki', email: 'test@wehaul.ng', role:'admin', password: 'Password', password_confirmation: 'Password', admin:true, phone_number:'090312345678'} ])
users.each do |user| 
  puts "Creating for #{user.name}"
  Profile.create(profile_picture: Faker::Avatar.image, user_id: user.id)
end
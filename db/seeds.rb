users = User.create([{name:'Eniola Roland', email: 'customer@wehaul.ng', role:'customer', user_type:'customer', password: 'Password', password_confirmation: 'Password', phone_number: '080323423422'}, {name:'Richard Igbiriki', email: 'admin@wehaul.ng', role:'admin', password: 'Password', password_confirmation: 'Password', phone_number:'090312345678', user_type:'admin'}, {name:'Driver User', email: 'driver@wehaul.ng', role:'driver', user_type:'driver', password: 'Password', password_confirmation: 'Password', phone_number: '0803234234221'}, ])
vehicle_type = VehicleType.create({name:'Lorry', description: "This is a lorry", max_price_per_km:1.5, min_price_per_km:1000, commission_rate:20})
users.each do |user| 
  puts "Creating for #{user.name}"
  Profile.create(profile_picture: Faker::Avatar.image, user_id: user.id)
  #create vehicles for each user
  Vehicle.create({user_id: user.id, plate_number:Faker::Lorem.word, license:Faker::Lorem.sentence, license_no: '23434', serial_no:Faker::Lorem.word, license_issue_date:Time.now-30.days, license_expiry_date:Time.now + 50.days, vehicle_type_id: vehicle_type.id })
  15.times do
    request = user.trip_requests.create({vehicle_type_id:vehicle_type.id, fee:1400, weight: 12, pickup_time: '10AM', pickup_date: Time.now, quantity:2 })
  end

  5.times do
    request = user.trip_requests.create({vehicle_type_id:vehicle_type.id, fee:1400, weight: 12, pickup_time: '10AM', pickup_date: Time.now, quantity:2, driver_id:user.id })
  end
  5.times do
    request = user.trip_requests.create({vehicle_type_id:vehicle_type.id, fee:5020, weight: 12, pickup_time: '12PM', pickup_date: Time.now, quantity:2, driver_id:user.id, status:'completed' })
  end
  5.times do
    request = user.trip_requests.create({vehicle_type_id:vehicle_type.id, fee:5000, weight: 12, pickup_time: '9AM', pickup_date: Time.now+2.days, quantity:2, driver_id:user.id, status: 'cancelled' })
  end
  10.times do
    reqs = user.trip_requests.create({vehicle_type_id:vehicle_type.id, fee:30000, weight: 12, pickup_time: '11AM', pickup_date: Time.now+3.days, quantity:2, driver_id:user.id, status: 'on_going' })
  end

  10.times do
    req = user.trip_requests.create({vehicle_type_id:vehicle_type.id, fee:30000, weight: 12, pickup_time: '11AM', pickup_date: Time.now+3.days, quantity:2, driver_id:user.id, status: 'on_going' })
    trip_activities = user.trip_activities.create({ activity: "Assigned trip to a driver", trip_request_id:req.id })
  end
end

5.times do 
  User.create({name:Faker::Name.name, email: Faker::Internet.email, role:'customer', user_type:'customer', password: 'Password', password_confirmation: 'Password', phone_number: '080323423422'})
end

5.times do
  User.create({name:Faker::Name.name, email: Faker::Internet.email, role:'driver', user_type:'driver', password: 'Password', password_confirmation: 'Password', phone_number: '080323423422'})
end
 superAdmin = User.create({name:Faker::Name.name, email: 'super@wehaul.ng', role:'super_admin', user_type:'super_admin', password: 'Password', password_confirmation: 'Password', phone_number: '1001000123'})
  Profile.create(profile_picture: Faker::Avatar.image, user_id: superAdmin.id)
users = User.create([{name:'Eniola Roland', email: 'customer@wehaul.ng', role:'customer', admin: false, user_type:'customer', password: 'Password', password_confirmation: 'Password', phone_number: '080323423422'}, {name:'Richard Igbiriki', email: 'admin@wehaul.ng', role:'admin', password: 'Password', password_confirmation: 'Password', admin:true, phone_number:'090312345678', user_type:'admin'} ])
vehicle_type = VehicleType.create({name:'Lorry', description: "This is a lorry", max_price_per_km:1000, min_price_per_km:100})
users.each do |user| 
  puts "Creating for #{user.name}"
  Profile.create(profile_picture: Faker::Avatar.image, user_id: user.id)
  #create vehicles for each user
  vehicles = []
  10.times do
    vehicle = user.vehicles.create({plate_number:Faker::Lorem.word, license:Faker::Lorem.sentence, license_no: '23434', serial_no:Faker::Lorem.word, license_issue_date:Time.now-30.days, license_expiry_date:Time.now + 50.days, vehicle_type_id: vehicle_type.id })
    vehicles<<vehicle
  end

  15.times do
    request = user.trip_requests.create({vehicle_type_id:vehicle_type.id, fee:1400, weight: 12, pickup_time: '10AM', pickup_date: Time.now, quantity:2 })
  end

  5.times do
    request = user.trip_requests.create({vehicle_type_id:vehicle_type.id, fee:1400, weight: 12, pickup_time: '10AM', pickup_date: Time.now, quantity:2, driver_id:user.id })
  end
end
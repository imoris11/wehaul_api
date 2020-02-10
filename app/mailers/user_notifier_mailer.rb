class UserNotifierMailer < ApplicationMailer
  default :from => 'test@wehaul.ng'
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Welcome To WeHaul' )
  end

  def send_added_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Welcome To WeHaul')
  end

  def send_new_request_email(trip, driver)
    @driver = driver
    @trip = trip
    mail( :to => @driver.email,
    :subject => 'Wehaul: New Matching Trip Request')
  end

  def send_user_request_email(trip, user)
    @user = user
    @trip = trip
    mail( :to => @user.email,
    :subject => 'Wehaul: New Trip Request')
  end

  def send_trip_completed_email(trip)
    @trip = trip 
    puts "Here to send email"
    mail( :to => @trip.user.email,
    :subject => 'Wehaul: Trip Completed')
  end

  def send_trip_update_email (trip)
    @trip = trip 
    mail( :to => @trip.user.email,
    :subject => 'Wehaul: Trip Update')
  end

  def send_payment_notification_admin (trip)
    @trip = trip 
    @admins = User.super_admin
    @admins.each do |admin|
      mail( :to => admin.email,
      :subject => 'Wehaul: New Trip Transaction')
    end
  end

  def send_payment_notification_driver (driver_id, amount)
    @driver = User.find(driver_id)
    @amount = amount
    mail( :to => @driver.email,
    :subject => 'Wehaul: New Payment Received')
  end

  def send_assignment_email(trip, driver)
    @driver = driver
    @trip = trip
    mail( :to => @driver.email,
    :subject => 'Wehaul: New Trip Assigned')
  end
end
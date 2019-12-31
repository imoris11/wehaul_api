class Admins::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update, :ban, :busy, :update_profile]
  def index
    customers = User.customer.paginate(page:params[:page], per_page:20)
    #customers = add_balance(customers)
    json_response(customers)
  end

  def show
    json_response(@customer)
  end

  def update
    @customer.update!(customer_params)
    json_response(@customer)
  end

  def update_profile 
    @customer.profile.update!(update_params)
    json_response(@customer)
  end

  def ban
   if @customer.banned?
    @customer.status = "active"
   else
    @customer.status = "banned"
   end
    @customer.save!
    json_response(@customer)
  end

  def stats
    all = User.customer.count
    banned = User.customer.banned.count
    response = { all: all, banned: banned} 
    json_response(response)
  end

  private 
  def set_customer
    @customer = User.find_by_token!(params[:id])
  end

  def add_balance(customers)
    customers.each do |customer|
      balance = customer.wallet.current_balance
    end
  end

   # Only allow a trusted parameter "white list" through.
   def customer_params
    params.permit(:name, :email,  :role, :phone_number, :user_type)
  end

  def update_params 
    params.permit(:address, :resident_state, :city, :country,  :profile_picture, :account_name, :account_number, :bank_name, :account_type, :referral_name)
  end
end

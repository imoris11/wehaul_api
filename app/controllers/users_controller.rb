class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :set_user, only: [:show, :update, :destroy, :update_profile]

  # GET /users
  def index
    @users = User.all.paginate(page:params[:page], per_page:20)
    json_response(@users)
  end

  # GET /users/1
  def show
    json_response(@user)
  end

  # POST /users
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # PATCH/PUT /users/1
  def update
    @user.update!(user_params)
    json_response(@user)
  end

  def update_profile
    @user.profile.update(update_params)
    json_response(@current_user)
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name, :email, :password, :password_confirmation, :role, :admin, :phone_number, :user_type)
    end

    def update_params 
      params.permit(:address, :resident_state, :city, :country,  :preferred_distance, :routes, :drivers_license, :driver_license_expiry_date,   :profile_picture, :account_name, :account_number, :bank_name, :account_type, :referral_name)
    end
end

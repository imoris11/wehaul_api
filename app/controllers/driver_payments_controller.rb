class DriverPaymentsController < ApplicationController
  before_action :set_driver_payment, only: [:show, :update, :destroy]
  before_action :set_driver, only: [:payments]

  # GET /driver_payments
  def index
    @driver_payments = DriverPayment.all.paginate(page:params[:page], per_page:20)
    json_response(@driver_payments)
  end

  # GET /driver_payments/1
  def show
    json_response(@driver_payment)
  end

  def payments
    payments = @driver.driver_payments.paginate(page:params[:page], per_page:20)
    trips = TripRequest.where('driver_id=?', @driver.id).count
    active = TripRequest.where('driver_id=?', @driver.id).active.count
    sum = @driver.driver_payments.sum(:amount)
    num_of_payments = @driver.driver_payments.count
    response = {payments:payments, trips:trips, active:active, sum: sum, num_of_payments: num_of_payments }
    json_response(response)
  end

  def own
    payments = current_user.driver_payments.paginate(page:params[:page], per_page:20)
    json_response(payments)
  end 

  # POST /driver_payments
  def create
    @driver_payment = DriverPayment.create!(driver_payment_params)
    UserNotifierMailer.send_payment_notification_driver(@driver_payment.user_id, @driver_payment.amount).deliver
    @driver_payment.trip_request.update!({driver_paid:true})
    json_response(@driver_payment, :created)
  end

  # PATCH/PUT /driver_payments/1
  def update
    @driver_payment.update!(driver_payment_params)
    json_response(@driver_payment)
  end

  # DELETE /driver_payments/1
  def destroy
    @driver_payment.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver_payment
      @driver_payment = DriverPayment.find_by_token!(params[:id])
    end

    def set_driver
      @driver = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driver_payment_params
      params.permit(:created_by, :paid_by, :user_id, :trip_request_id, :is_paid, :amount, :has_responded)
    end
end

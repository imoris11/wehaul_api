class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :update, :destroy]

  # GET /notifications
  def index
    @notifications = Notification.all.paginate(page:params[:id], per_page:20)
    json_response(@notifications)
  end

  # GET /notifications/1
  def show
    json_response(@notification)
  end

  # POST /notifications
  def create
    @notification = Notification.create!(notification_params)
    json_response(@notification, :created)
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:target, :messsage, :is_read, :user_id)
    end
end

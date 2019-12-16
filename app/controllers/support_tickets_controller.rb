class SupportTicketsController < ApplicationController
  before_action :set_support_ticket, only: [:show, :update, :destroy]

  # GET /support_tickets
  def index
    @support_tickets = SupportTicket.all.paginate(page:params[:page], per_page:20)
    json_response(@support_tickets)
  end

  # GET /support_tickets/1
  def show
    json_response(@support_ticket)
  end

  # POST /support_tickets
  def create
    @support_ticket = current_user.support_tickets.create!(support_ticket_params)
    json_response(@support_ticket, :created)
  end

  # PATCH/PUT /support_tickets/1
  def update
    @support_ticket.update!(support_ticket_params)
    json_response(@support_ticket)
  end

  # DELETE /support_tickets/1
  def destroy
    @support_ticket.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_support_ticket
      @support_ticket = SupportTicket.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def support_ticket_params
      params.permit(:user_id, :trip_request_id, :mark_as_read, :is_resolved, :content, :topic)
    end
end

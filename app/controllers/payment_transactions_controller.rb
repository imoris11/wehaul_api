class PaymentTransactionsController < ApplicationController
  before_action :set_payment_transaction, only: [:show, :update, :destroy]

  # GET /payment_transactions
  def index
    @payment_transactions = PaymentTransaction.all.paginate(page: params[:page], per_page:20)
    json_response( @payment_transactions)
  end

  # GET /payment_transactions/1
  def show
   json_response(@payment_transaction) 
  end

  # POST /payment_transactions
  def create
    @payment_transaction = current_user.payment_transactions.create!(payment_transaction_params)
    json_response(@payment_transaction, :created)
  end

  # PATCH/PUT /payment_transactions/1
  def update
    @payment_transaction.update!(payment_transaction_params)
    json_response(@payment_transaction)
  end

  # DELETE /payment_transactions/1
  def destroy
    @payment_transaction.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_transaction
      @payment_transaction = PaymentTransaction.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def payment_transaction_params
      params.permit(:user_id, :transaction_ref, :medium, :amount)
    end
end

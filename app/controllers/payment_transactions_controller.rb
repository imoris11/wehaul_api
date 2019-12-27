class PaymentTransactionsController < ApplicationController

  before_action :set_payment_transaction, only: [:show, :update, :destroy]
  # GET /payment_transactions
  def index
    @payment_transactions = PaymentTransaction.all.paginate(page: params[:page], per_page:20)
    json_response( @payment_transactions)
  end

  def verify_payment
    paystackObj =  Paystack.new
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.verify(params[:trxRef])
    if result['data']['status'] == "success" 
      depositAmount = result['data']['amount']/100
      current_user.payment_transactions.create(medium:result['data']['channel'], amount: depositAmount, transaction_ref: result['data']['reference'])
      prev_balance = current_user.wallet.current_balance
      amount = current_user.wallet.current_balance + depositAmount
      current_user.wallet.update!({current_balance: amount, created_by:current_user.id, prev_balance:prev_balance, amount: depositAmount })
      json_response({result:result, balance:current_user.wallet.current_balance, transactions: current_user.payment_transactions.count })
    else
      json_response(result)
    end
   
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

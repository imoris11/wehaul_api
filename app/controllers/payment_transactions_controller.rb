class PaymentTransactionsController < ApplicationController

  before_action :set_payment_transaction, only: [:show, :update, :destroy]
  before_action :set_user, only: [:transactions]
  # GET /payment_transactions
  def index
    @payment_transactions = PaymentTransaction.all.paginate(page: params[:page], per_page:20)
    json_response( @payment_transactions)
  end
  
  def wallet_topup
    paystackObj =  Paystack.new
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.verify(params[:trxRef])
    if params[:user_id].present?
      user = User.find(params[:user_id])
    else
      user = current_user
    end

    if result['data']['status'] == "success" && result['data']['amount'] == params[:amount]
      depositAmount = result['data']['amount']/100
      user.payment_transactions.create(medium:result['data']['channel'], amount: depositAmount, transaction_ref: result['data']['reference'], message:"wallet topup using paystack", deposit_type: "wallet topup")
      amount = user.wallet.current_balance + depositAmount
      user.wallet.update!({current_balance: amount })
      json_response({result:result, balance:user.wallet.current_balance, transactions: user.payment_transactions.count })
    else
      json_response(result)
    end
   
  end

  def own 
    @transactions = current_user.payment_transactions.paginate(page: params[:page], per_page:20)
    json_response(@transactions)
  end

  def transactions
    @transactions = @user.payment_transactions.paginate(page: params[:page], per_page:20)
    json_response(@transactions)
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

    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def payment_transaction_params
      params.permit(:user_id, :transaction_ref, :medium, :amount, :message, :deposit_type)
    end
end

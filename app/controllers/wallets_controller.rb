class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :update, :destroy]

  # GET /wallets
  def index
    @wallets = Wallet.all.paginate(page:params[:page], per_page:20)
    json_response(@wallets)
  end

  # GET /wallets/1
  def show
    json_response(@wallet)
  end

  # PATCH/PUT /wallets/1
  def update
    @wallet.update!(wallet_params)
    json_response(@wallet)
  end

  # DELETE /wallets/1
  def destroy
    @wallet.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wallet_params
      params.permit(:created_by, :amount, :prev_balance, :current_balance, :payment_reference, :is_valid, :source, :type)
    end
end

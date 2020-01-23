class WalletsController < ApplicationController
  before_action :set_wallet, only: [ :destroy]
  before_action :set_user, only: [:user_wallet]
  def index 
    json_response(current_user.wallet)
  end

  def user_wallet
    json_response(@user.wallet)
  end
  def update_balance
    prev_balance = current_user.wallet.current_balance
    amount = current_user.wallet.current_balance + params[:amount]
    current_user.wallet.update!({current_balance: amount })
    json_response(current_user.wallet)
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

    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wallet_params
      params.permit(:amount)
    end
end

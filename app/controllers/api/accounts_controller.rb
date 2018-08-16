class Api::AccountsController < ApplicationController
  def create
    params[:account][:password] = SecureRandom.hex(4)
    @account = Account.new(account_params)
    if @account.save
      render :create
    else
      render json: @account.errors.full_messages, status: 422
    end
  end

  def show
    if !params[:account]
      render json: ["Invalid account/password. Provide account password info under account key like so: account[password]"], status: 401
    else
      @account = Account.find_by_credentials(params[:id], params[:account][:password])
      if @account
        render :show
      else
        render json: ["Incorrect account number/password combination"], status: 401
      end
    end
  end

  def deposit
    if !params[:account]
      render json: ["Provide account password info under account key like so: account[password]"], status: 401
    else
      @account = Account.find_by_credentials(params[:id], params[:account][:password])
      if !@account
        render json: ["Incorrect account number/password combination"], status: 401
      elsif !params[:account][:amount]
        render json: ["Provide a key of amount (account[amount]) and an integer amount to deposit"], status: 422
      else
        @account.amount += params[:account][:amount].to_f
        @account.save
        render :show
      end
    end
  end

  def withdraw
    if !params[:account]
      render json: ["Provide account password info under account key like so: account[password]"], status: 401
    else
      @account = Account.find_by_credentials(params[:id], params[:account][:password])
      if !@account
        render json: ["Incorrect account number/password combination"], status: 401
      elsif !params[:account][:amount]
        render json: ["Provide a key of amount (account[amount]) and an integer amount to withdraw"], status: 422
      else
        if @account.amount - params[:account][:amount].to_f < 0 
          render json: ["Cannot withdraw more than amount in account"], status: 422
        else
          @account.amount -= params[:account][:amount].to_f
          @account.save
          render :show
        end
      end
    end
  end

  private
  def account_params
    @account_params = params.require(:account).permit(:name, :account_num, :password, :amount)
  end
end
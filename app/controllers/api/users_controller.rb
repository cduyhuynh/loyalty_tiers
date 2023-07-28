class Api::UsersController < ApplicationController
  before_action :find_user, only: [:show, :orders]
  def show
    user = service.show
    render json: user, status: :ok
  end

  def orders
    result = order_service.list_by @user
    render json: result, status: :ok
  end

  private
  def find_user
    begin
      user_id = params[:id] || params[:user_id]
      @user ||= User.find user_id
    rescue
      render json: { message: 'User not found' }, status: 400
    end
  end

  def service
    @service ||= UserService.new @user
  end

  def order_service
    @order_service ||= OrdersService.new
  end
end
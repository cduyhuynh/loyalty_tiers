class Api::UsersController < ApplicationController
  before_action :find_user, only: :show
  def show
    user = service.show
    render json: user, status: :ok
  end

  private
  def find_user
    begin
      @user ||= User.find params[:id]
    rescue
      render json: { message: 'User not found' }, status: 400
    end
  end

  def service
    @service ||= UserService.new @user
  end
end
class Api::OrdersController < ApplicationController
  before_action :find_order, only: :complete
  def complete
    order = service.complete @order, complete_params
    render json: { message: 'Order completed', order: order }, status: :ok
  end

  protected
  def service
    @service ||= OrdersService.new
  end

  def find_order
    begin
      @order ||= Order.find params[:id]
    rescue
      render json: { message: 'Order not found' }, status: 400
    end
  end

  def complete_params
    params.permit(:customerId, :totalInCents)
  end
end
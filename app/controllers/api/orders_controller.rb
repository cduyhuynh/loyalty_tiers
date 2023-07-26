class Api::OrdersController < ApplicationController
  before_action :find_order, only: :complete
  def complete
    order = service.complete @order, complete_params
    render json: { message: 'Order completed', order: order }, status: :ok
  end

  protected
  def service
    @service ||= OrderService.new
  end

  def find_order
    @order ||= Order.find params[:id]
    render json: { message: 'Order not found' }, status: 400 if @order.nil?
  end

  def complete_params
    params.permit(:customerId, :totalInCents)
  end
end
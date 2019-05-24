require 'stripe'
require 'securerandom'

class Api::V1::ChargesController < ApplicationController

  def new
  end

  def create

  Stripe.api_key = 'sk_test_Sh3JmNAY6uuHzkyf2Gh51gVO00W8XJk3im'
  ip_key = SecureRandom.uuid

  begin

    customer = Stripe::Customer.create(
    :email => current_user.email,
    :source => params[:charge][:token]
    )

    puts customer

    charge = Stripe::Charge.create({
    :customer => customer.id,
    :amount => params[:charge][:amount],
    :description => params[:charge][:description],
    :currency => params[:charge][:currency],
    }, {
    :idempotency_key => ip_key
    })

    puts charge

  rescue Stripe::CardError => e
    render json: { message: 'oops'}, status: :not_acceptable
  end
end

  private

  # def charge_params
  #   params.require(:charge).permit(:amount, :currency, :description, :chargeToken)
  # end

end

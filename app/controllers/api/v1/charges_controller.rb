require 'stripe'
require 'securerandom'

class Api::V1::ChargesController < ApplicationController

  def create

  Stripe.api_key = 'sk_test_Sh3JmNAY6uuHzkyf2Gh51gVO00W8XJk3im'
  ip_key = SecureRandom.uuid

  customer = Stripe::Customer.create(
  :email => current_user.email,
  :source => params[:token]
  )

  charge = Stripe::Charge.create(
  :customer => customer.id,
  :amount => params[:amount],
  :description => params[:description],
  :currency => params[:currency],
  :idempotency_key => ip_key
  )

  rescue Stripe::CardError => e
    render json: { message: 'oops'}, status: :not_acceptable
  end

  private

  def charge_params
    params.require(:charge).permit(:amount, :description, :currency)
  end

end

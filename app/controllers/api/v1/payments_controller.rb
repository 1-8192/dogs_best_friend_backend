class Api::V1::PaymentsController < ApplicationController

  def create
    @payment = Payment.create(payment_params)
    if @payment.valid?
      render json: {user: UserSerializer.new(@payment.user), dog: DogSerializer.new(@payment.dog)}, status: :accepted
    else
      render json: { message: "error processing payment"}, status: :not_acceptable
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :dog_id, :note, :user_id)
  end

end

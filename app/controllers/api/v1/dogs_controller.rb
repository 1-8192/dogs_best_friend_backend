class Api::V1::DogsController < ApplicationController
skip_before_action :authorized, only: [:index, :show]

  def index
    @dogs = Dog.all
    render json: @dogs
  end

  def show
    @dog = Dog.find(params[:id])
    render json: { dog: DogSerializer.new(@dog), total_payments: @dog.total_payments }
  end

end

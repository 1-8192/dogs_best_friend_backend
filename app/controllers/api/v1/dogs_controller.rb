class Api::V1::DogsController < ApplicationController
skip_before_action :authorized, only: [:index, :show, :sorted_index]

  def index
    @dogs = Dog.all
    render json: @dogs
  end

  def sorted_index
    @dogs = Dog.order_of_need
    render json: @dogs
  end

  def show
    @dog = Dog.find(params[:id])
    render json: { dog: DogSerializer.new(@dog), total_payments: @dog.total_payments }
  end

end

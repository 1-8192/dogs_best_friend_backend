class Api::V1::SheltersController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @shelters = Shelter.all
    render json: @shelters
  end
end

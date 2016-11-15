class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
  end

  def create
    # raise params.inspect
    Restaurant.create(params[:restaurant])
    redirect_to '/restaurants'
  end

end

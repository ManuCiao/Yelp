class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find params[:restaurant_id]
    @review = @restaurant.build_with_user(review_params, current_user)
    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        # Note: if you have correctly disabled the review button where appropriate,
        # this should never happen...
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        # Why would we render new again?  What else could cause an error?
        render :new
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end

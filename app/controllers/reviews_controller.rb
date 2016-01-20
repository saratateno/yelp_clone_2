class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if ! current_user.has_reviewed?(@restaurant)
      flash[:alert] = 'Cannot review same restaurant twice'
      redirect_to "/restaurants"
    end
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)

    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:opinion, :rating)
  end
end

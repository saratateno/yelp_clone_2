class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed?(@restaurant)
      flash[:alert] = 'Cannot review same restaurant twice'
      redirect_to "/restaurants"
    end
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user review_params, current_user

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user.reviews.include?(@review)
      @review.destroy
      flash[:notice]= "Review has been deleted"
    else
      flash[:alert]= "Incorrect User"
    end
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:opinion, :rating)
  end
end

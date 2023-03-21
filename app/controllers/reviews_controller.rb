class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @unicorn = Unicorn.find(params[:unicorn_id])
    @review.unicorn = @unicorn
    if @review.save
      redirect_to unicorn_path(@unicorn), alert: "Your review has been saved"

    else
      flash[:alert] = "Something went wrong."
      render :new
    end
    authorize @review
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end

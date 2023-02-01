class UnicornsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :get_unicorn, only: [:show, :destroy, :edit, :update]

  def index
    @unicorns = Unicorn.all
  end

  def show
    @booking = Booking.new
    @review = Review.new
  end

  def new
    @unicorn = Unicorn.new
  end

  def create
    @unicorn = Unicorn.new(unicorn_params)
    @unicorn.user = current_user
    @unicorn.save!
    redirect_to unicorns_path
  end

  private

  def get_unicorn
    @unicorn = Unicorn.find(params[:id])
  end

  def unicorn_params
    params.require(:unicorn).permit(:name, :description, :price, :image_url, :location)
  end

end

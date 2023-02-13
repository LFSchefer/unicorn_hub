class UnicornsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :get_unicorn, only: [:show, :destroy, :edit, :update]

  def index
    if params[:query].present?
      sql_query = <<~SQL
      unicorns.name ILIKE :query
      OR unicorns.description ILIKE :query
      OR unicorns.location ILIKE :query
      OR CAST(unicorns.price AS TEXT) ILIKE :query
      SQL
      @unicorns = Unicorn.where(sql_query, query: "%#{params[:query]}%")
    else
      @unicorns = Unicorn.all
    end

    respond_to do |format|
      format.html
      format.text {render partial: "unicorn_card",locals: {unicorns: @unicorns}, formats: [:html]}
    end
  end

  def show
    @booking = Booking.new
    @review = Review.new
    @reviews = Review.where(unicorn_id: params[:id]).last(5)
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

  def timer
    # teste timer JS
  end

  private

  def get_unicorn
    @unicorn = Unicorn.find(params[:id])
  end

  def unicorn_params
    params.require(:unicorn).permit(:name, :description, :price, :image_url, :location)
  end

end

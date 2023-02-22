class UnicornsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :get_unicorn, only: [:show, :destroy, :edit, :update]
  skip_after_action :verify_policy_scoped, :only => :index


  def index

    if params[:query].present?
      sql_query = <<~SQL
      unicorns.name ILIKE :query
      OR unicorns.description ILIKE :query
      OR unicorns.location ILIKE :query
      OR CAST(unicorns.price AS TEXT) ILIKE :query
      SQL
      @unicorns = policy_scope(Unicorn).where(sql_query, query: "%#{params[:query]}%")
    else
      @unicorns = policy_scope(Unicorn)
    end

    respond_to do |format|
      format.html
      format.text {render partial: "unicorn_card",locals: {unicorns: @unicorns}, formats: [:html]}
    end

  end

  def show

    authorize @unicorn

    @booking = Booking.new
    @review = Review.new
    @reviews = Review.where(unicorn_id: params[:id]).last(5)
  end

  def new
    @unicorn = Unicorn.new
    authorize @unicorn
  end

  def create
    @unicorn = Unicorn.new(unicorn_params)
    @unicorn.user = current_user
    @unicorn.save!
    redirect_to unicorns_path
    authorize @unicorn
  end

  def timer
    # teste timer JS
    @timer = 3000
    @unicorn = Unicorn.first
  end

  private

  def get_unicorn
    @unicorn = Unicorn.find(params[:id])
  end

  def unicorn_params
    params.require(:unicorn).permit(:name, :description, :price, :image_url, :location)
  end

end

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
      @unicorns = policy_scope(Unicorn).where(sql_query, query: "%#{params[:query]}%").order(created_at: :asc)
    else
      @unicorns = policy_scope(Unicorn).order(created_at: :asc)
    end



    respond_to do |format|
      format.html
      format.text { render partial: "unicorn_card",locals: {unicorns: @unicorns}, formats: [:html] }
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

  def edit
    authorize @unicorn
  end

  def update
    if @unicorn.update(unicorn_params)
    redirect_to unicorn_path(@unicorn), alert: "Unicorn Update"
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
    authorize @unicorn
  end

  # For testing
  def timer
    @timer = 3000
    @unicorn = Unicorn.first
    authorize @unicorn
    if params[:commit] == "Send"
      @unicorn = Unicorn.find(rand(Unicorn.first.id..Unicorn.last.id))
    end
  end
  # For testing

  private

  def get_unicorn
    @unicorn = Unicorn.find(params[:id])
  end

  def unicorn_params
    params.require(:unicorn).permit(:name, :description, :price, :image_url, :location)
  end

end

class UnicornsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :get_unicorn, only: [:show, :destroy, :edit, :update]

  def index


    # TODO tag select


    if params[:query].present?
      sql_query = <<~SQL
      unicorns.name ILIKE :query
      OR unicorns.description ILIKE :query
      OR unicorns.address ILIKE :query
      OR CAST(unicorns.price AS TEXT) ILIKE :query
      SQL
      @unicorns = policy_scope(Unicorn).where(sql_query, query: "%#{params[:query]}%").order(created_at: :asc)
    else
      @unicorns = policy_scope(Unicorn).order(created_at: :asc)
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'unicorn_card',locals: {unicorns: @unicorns}, formats: [:html] }

    end

  end

  def show

    authorize @unicorn

    @tags = Tag.all
    @booking = Booking.new
    @review = Review.new
    @reviews = Review.where(unicorn_id: params[:id]).last(15)
    if @unicorn.geocoded?
      @markers = [
        lat: @unicorn.latitude,
        lng: @unicorn.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: {unicorn: @unicorn})
      ]
    end
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
      redirect_to unicorn_path(@unicorn), alert: 'Unicorn Update'
    else
      flash[:alert] = 'Something went wrong'
      render :new
    end
    authorize @unicorn
  end

  def destroy
    if current_user.id == @unicorn.user_id
      @unicorn.destroy
      redirect_to unicorns_path
    else
      flash[:alert] = 'Unautorize to delete'
    end
    authorize @unicorn
  end

  # For testing purpuse
  def timer
    @timer = 3653
    @unicorn = Unicorn.first
    authorize @unicorn
    if params[:commit] == 'Answer'
      @unicorn = Unicorn.find(rand(Unicorn.first.id..Unicorn.last.id))
    end
    # raise
  end
  # For testing purpuse

  private

  def get_unicorn
    @unicorn = Unicorn.find(params[:id])
  end

  def unicorn_params
    params.require(:unicorn).permit(:name, :description, :price, :image_url, :address)
  end

end

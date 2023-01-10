class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(bookings_params)
    @booking.user = current_user
    @unicorn = Unicorn.find(params[:unicorn_id])
    @booking.unicorn = @unicorn
    if @booking.save
      redirect_to unicorn_path(@unicorn), alert: "Your unicorn has been booked"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bookings_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

class UnicornTagsController < ApplicationController

  def new
    @unicorntag = UnicornTags.new
  end

  def create
    redirect_to root_path
  end

  def update
    raise
  end

  private

  def unicorntags_params
    params.require(:unicorntag).permit()
  end
end

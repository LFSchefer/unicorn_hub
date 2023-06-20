class UnicornTagsController < ApplicationController
  before_action :skip_authorization

  def new
    @unicorn = Unicorn.find(params[:unicorn_id])
    @unicorn_tag = UnicornTag.new
  end

  def create
    @unicorn = Unicorn.find(params[:unicorn_id])
    @tags = Tag.where(id: params.dig(:unicorn_tag, :tag))

    ActiveRecord::Base.transaction do
      @tags.each do |tag|
        plant_tag = UnicornTag.new(unicorn: @unicorn, tag: tag)
        plant_tag.save!
      end
      redirect_to unicorn_path(@unicorn)
    end
  rescue ActiveRecord::RecordInvalid
    render_new
  end

  def destroy
    @unicorn = Unicorn.find(params[:unicorn_id])
    @unicorn_tags = UnicornTag.where(unicorn: @unicorn)
    @unicorn_tags.destroy_all
    redirect_to unicorn_path(@unicorn)
  end

  private

  def render_new
    @unicorn_tag = UnicornTag.new
    @unicorn_tag.errors.add(:base, "A selected already exists")
    render :new, status: :unprocessable_entity
  end

end

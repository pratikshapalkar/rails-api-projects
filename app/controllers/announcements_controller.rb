class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sport
  before_action :set_post
  before_action :set_announcement, only: [:update, :show, :destroy]

   ## List All Categories API
   def index
    anouncements = @sport.anouncements

    render_success 200, true, 'Categories fetched successfully', anouncements.as_json
  end

  ## Create a Category API
  def create
    anouncement = @sport.anouncements.new(anouncements_params)
    anouncement.sport_id = @sport.id

    if anouncement.save
      render_success 200, true, 'Category created successfully', anouncement.as_json
    else
      if anouncement.errors
        errors = anouncement.errors.full_messages.join(", ")
      else
        errors = 'Category creation failed'
      end

      return_error 500, false, errors, {}
    end
  end

  ## Update a Category API
  def update
    if @anouncement.update(anouncements_params)
      render_success 200, true, 'Category updated successfully', @anouncement.as_json
    else
      if @anouncement.errors
        errors = @anouncement.errors.full_messages.join(", ")
      else
        errors = 'Category update failed'
      end

      return_error 500, false, errors, {}
    end
  end

  ## Fetch a Category API
  def show
    render_success 200, true, 'Category fetched successfully', @anouncement.as_json
  end

  ## Delete a Category API
  def destroy
    @anouncement.destroy

    render_success 200, true, 'Category deleted successfully', {}
  end

  private

  # Strong Params of Category
  def anouncements_params
    params.require(:anouncement).permit(:description, :sport_id)
  end

  ## Set Language Object, Return Error if not found
  def set_post
    @sport = @sport.posts.where(id: params[:post_id]).first

    unless @sport
      return return_error 404, false, 'Language not found', {}
    end
  end

  ## Set Category Object, Return Error if not found
  def set_category
    @anouncement = @sport.anouncements.where(id: params[:id]).first

    unless @anouncement
      return return_error 404, false, 'Category not found', {}
    end
  end
end

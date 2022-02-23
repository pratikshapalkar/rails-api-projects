class AnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sport
  before_action :set_announcement, only: [:update, :show, :destroy]

  ## GET /sports/:sport_id/anouncements
  def index
    anouncements = @sport.anouncements.page(params[:page]).per(per_page)

    render_success 200, true, 'Announcement fetched successfully', anouncements.as_json
  end

  ## POST /sports/:sport_id/anouncements
  def create
    anouncement = @sport.anouncements.new(anouncements_params)
    anouncement.sport_id = @sport.id

    if anouncement.save && current_user.admin?
      render_success 200, true, 'Announcement created successfully', anouncement.as_json
    else
      if anouncement.errors
        errors = anouncement.errors.full_messages.join(", ")
      else
        errors = 'Announcement creation failed'
      end

      return_error 500, false,'Only admin can create announcements'
    end
  end

  ## PATCH /sports/:sport_id/anouncements/:id
  def update
    if @anouncement.update(anouncements_params) && current_user.admin?
      render_success 200, true, 'Announcement updated successfully', @anouncement.as_json
    else
      if @anouncement.errors
        errors = @anouncement.errors.full_messages.join(", ")
      else
        errors = 'Announcement update failed'
      end

      return_error 500, false, errors, {}
    end
  end

  ## GET /sports/:sport_id/anouncements/:id
  def show
    render_success 200, true, 'Announcement fetched successfully', @anouncement.as_json
  end

  ## DELETE /sports/:sport_id/anouncements/:id
  def destroy
    if current_user.admin?
    @anouncement.destroy

    render_success 200, true, 'Announcement deleted successfully', {}
    else
      return_error 500, false,'Only admin can delete announcements'
    end
  end

  private

  # Strong Params of Announcement
  def anouncements_params
    params.require(:anouncement).permit(:description, :sport_id)
  end

  ## Set Announcement Object, Return Error if not found
  def set_announcement
    @anouncement = @sport.anouncements.where(id: params[:id]).first

    unless @anouncement
      return return_error 404, false, 'Announcement not found', {}
    end
  end
end

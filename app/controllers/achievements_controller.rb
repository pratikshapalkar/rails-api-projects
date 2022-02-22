class AchievementsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_sport
  before_action :set_achievement, only: [:update, :show, :destroy]

   ## List All Announcement API
   def index
    achievements = @sport.achievements

    render_success 200, true, 'Achievements fetched successfully', achievements.as_json
  end

  ## Create a Announcement API
  def create
    achievement = @sport.achievements.new(achievements_params)
    achievement.sport_id = @sport.id
    if achievement.save
      render_success 200, true, 'Achievement created successfully', achievement.as_json
    else
      if achievement.errors
        errors = achievement.errors.full_messages.join(", ")
      else
        errors = 'Achievement creation failed'
      end

      return_error 500, false, errors, {}
    end
  end

  ## Update a Achievement API
  def update
    if current_user.admin?
      if @achievement.update(admin_params)
      render_success 200, true, 'Achievement updated successfully', @achievement.as_json
      else
      if @achievement.errors
        errors = @achievement.errors.full_messages.join(", ")
      else
        errors = 'Achievement update failed'
      end

      return_error 500, false, errors, {}
      end
    end
  end

  ## Fetch a Achievement API
  def show
    render_success 200, true, 'Achievement fetched successfully', @achievement.as_json
  end

  ## Delete a Announcement API
  def destroy
    @achievement.destroy

    render_success 200, true, 'Achievement deleted successfully', {}
  end

  private

  # Strong Params of Announcement
  def achievements_params
    params.require(:achievement).permit(:award, :medals,:user_id,:sport_id)
  end

  # if admin is user then he can add the status for players achievement
  def admin_params
    params.require(:achievement).permit(:status)
  end

  ## Set Announcement Object, Return Error if not found
  def set_achievement
    @achievement = @sport.achievements.where(id: params[:id]).first

    unless @achievement
      return return_error 404, false, 'Achievement not found', {}
    end
  end
end

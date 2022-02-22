class SportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sport, only: [:update, :show, :destroy]

  # GET /sports
  def index
    @sports = Sport.page(params[:page]).per(per_page)

    render_success 200, true, 'Sports fetched successfully', @sports.as_json
  end

  # GET /sports/1
  def show
    render_success 200, true, 'All Sports', @sport.as_json
  end

  # POST /sports
  def create
    @sport = Sport.new(sport_params)

    if @sport.save && current_user.admin?
      render_success 200, true, 'Sport created successfully', @sport.as_json  
    else
      if @sport.errors
        errors = @sport.errors.full_messages.join(", ")
      else
        errors = 'Sport creation failed'
      end

      return_error 500, false, errors, {}
    end
  end

  # PATCH/PUT /sports/1
  def update
    if @sport.update(sport_params) && current_user.admin?
      render_success 200, true, 'Sport update successfully', @sport.as_json
    else
      errors = 'Sport updation failed'
    end
      
    return_error 500, false, errors, {} 
  end

  # DELETE /sports/1
  def destroy
    if @sport.destroy && current_user.admin?
      render_success 200, true, 'Sport deleted successfully'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport
      @sport = Sport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sport_params
       params.require(:sport).permit(:name)
    end
end

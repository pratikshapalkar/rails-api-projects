class SportsController < ApplicationController
  before_action :set_sport, only: [:update, :show, :destroy]

  # GET /sports
  def index
    @sports = Sport.all

    render json: @sports
  end

  # GET /sports/1
  def show
    render json: @sport
  end

  # POST /sports
  def create
    @sport = Sport.new(sport_params)

    if @sport.save && current_user.admin?
      render json: @sport, status: :created, location: @sport  
    else
       render json: @sport.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sports/1
  def update
    if @sport.update(sport_params) && current_user.admin?
      render json: @sport
    else
      render json: @sport.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sports/1
  def destroy
    @sport.destroy && current_user.admin?
    render json: @sport.as_json, status: :ok, message:'Sport deleted successfully'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport
      @sport = Sport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sport_params
       params.require(:sport).permit(:name,:no_of_player)
    end
end

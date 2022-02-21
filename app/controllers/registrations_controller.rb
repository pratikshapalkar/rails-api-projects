class RegistrationsController < DeviseTokenAuth::RegistrationsController
  # before_action :find_user, except: %i[create index]
  before_action :authenticate_user, only: [:create, :show, :update]
  
   # GET /resource/sign_up
  def new
    build_resource({})
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource
  end

  def create!
    user = User.new(user_params)

    if user.save 
      token = user.generate_jwt
      render json: token.to_json
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    render json: User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end
end
  private

  

  def user_params
    params.permit(:name, :email,:gender,:city,:state,:country)
  end



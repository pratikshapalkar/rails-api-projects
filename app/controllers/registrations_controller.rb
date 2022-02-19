class RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :find_user, except: %i[create index]

  def create
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
  

  private

  def find_user
    @user = User.find_by_username!(params[:email])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :product_id)
  end

end

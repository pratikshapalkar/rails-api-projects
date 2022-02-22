class RegistrationsController < DeviseTokenAuth::RegistrationsController
  
  # GET /resource/sign_up
  def create
    user = User.new(sign_up_params)
    if user.save 
      render_success 200, true, 'User created successfully',user.as_json
    else
      return_error 500, false, errors, {}
    end
  end
  
  private

  # parameters for sign up
  def sign_up_params
    params.require(:user).permit(:email,:password,:password_confirmation,:uid,:provider,:name)
  end
  #if we specify sign_up params by this we need to add parameters in postman like user[name] this way
end



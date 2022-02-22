class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  ## Callbacks
  # before_action :validate_app_version

  ## Custom Authentication Error Message
  def render_authenticate_error
        return_error 401, false, 'You need to sign in or sign up before continuing.', {}
  end
  
  def authenticate_user
    if current_user
       render_success 200, true, 'Authenticated successfully'
    else
      return_error 500, false, errors, {}
    end
  end
  protected
  
  ## Return Success Response
  def render_success code, status, message, data = {}
    render json: {
      code: code,
      status: status,
      message: message,
      data: data,
      per_page: per_page
  }
  end
    
  ## Return Error Response
  def return_error(code, status, message, data = {})
    render json: {
      code: code,
      status: status,
      message: message,
      data: data
  }
  end

  ## Check for Latest App Version
  def validate_app_version
    if Rails.application.credentials[Rails.env.to_sym][:app_version].to_f > request.headers["app-version"].to_f
      return_error 433, false, 'Please check your app version', {}
    end
  end
    
  ## Pagination Page Number
  def page
    @page ||= params[:page] || 1
  end
    
  ## Pagination Per Page Records
  def per_page
    @per_page ||= params[:per_page] || 2
  end
    
      ## Set Product & Return ERROR if not found
  def set_sport
    @sport = Sport.where(id: params[:sport_id]).first
    
    unless @sport
      return return_error 404, false, 'Product not found', {}
    end
  end
end

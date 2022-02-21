class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        ## Custom Authentication Error Message
  def render_authenticate_error
        return_error 401, false, 'You need to sign in or sign up before continuing.', {}
      end
    
      protected
    
      ## Return Success Response
      def render_success code, status, message, data = {}
        render json: {
            code: code,
            status: status,
            message: message,
            data: data
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
    
    
      ## Pagination Page Number
      def page
        @page ||= params[:page] || 1
      end
    
      ## Pagination Per Page Records
      def per_page
        @per_page ||= params[:per_page] || 20
      end
    
      ## Set Product & Return ERROR if not found
      def set_sport
        @sport = Sport.where(id: params[:sport_id]).first
    
        unless @sport
          return return_error 404, false, 'Product not found', {}
        end
      end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate_user_from_token!
	  user = AuthenticationService.authenticate_user(params[:auth_token])

	  if user
		  sign_in user, store: false
	  else
		  render json: {}, status: 401
	  end
	end

	def record_not_found
		render json: {}, status: 404
	end
end

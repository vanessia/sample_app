module SessionsHelper

	def sign_in(user)
	  cookies.permanent[:remember_token] = user.remember_token
	  current_user = user # to create current_user variable accessible in both controllers and views 	
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		#set the @current_user instance variable to the user corresponding to the remember token, but only if @current_user is undefined
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in"
      # same as flash[:notice] = "Please sign in" redirect_to signin_path
    end
  end


	def signed_in?
		!current_user.nil?
	end

	def sign_out
		current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end

end

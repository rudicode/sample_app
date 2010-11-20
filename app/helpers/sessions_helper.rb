module SessionsHelper
	def sign_in (user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		
		# create current_user to be accessible in controllers and views
		current_user = user
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		
		@current_user ||= user_from_remember_token
			# above is shorthand for @current_user = @current_user || user_from_remember_token
			# returns @current_user if it is not nil else it calls user_from_remember_token
	end
	
	def signed_in?
		!current_user.nil?
			# if current_user is not nil then they are signed in
	end
	
	def sign_out
		cookies.delete(:remember_token)
		current_user = nil
	end
	
	def current_user?(user)
		user == current_user
	end
	
	def authenticate
		deny_access unless signed_in?
	end
	
	def deny_access
		store_location
		redirect_to signin_path, :notice => "Please sign in to access this page."
	end
	
	def store_location
		session[:return_to] = request.fullpath
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end
	
	def clear_return_to
		session[:return_to] = nil
	end
		
	private
	
		def user_from_remember_token
			User.authenticate_with_salt(*remember_token)
				# * operator, which allows us to use a two-element array as an
				# argument to a method expecting two variables
		end
		
		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
				# in the remember_token helper method use the || operator to return
				# an array of nil values if cookies.signed[:remember_me] itself is nil
		end
	
end

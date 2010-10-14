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

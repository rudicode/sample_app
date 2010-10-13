class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    # render 'new'
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      # create an error message and re-render the sign in form
      flash.now[:error] = "Invalid email or pasword combination."
      @title="Sign in"
      render 'new'
    else
      # sign the user in and redirect to the users show page
    end
  end
  
  def destroy
  end

end

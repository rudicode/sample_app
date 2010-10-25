class UsersController < ApplicationController
	
	before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user, :only => :destroy
	before_filter :signed_in_user, :only => [:new, :create]
	
  def new
		@user = User.new
		@title="Sign Up"
  end

	def index
		@title = "All users"
		@users = User.paginate(:page => params[:page])
	end
	
	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success]="Welcome to the sample app"
			redirect_to @user
		else
			@title="Sign Up"
			@user.password=""
			@user.password_confirmation=""
			render 'new'
		end
	end
	
	def edit
		#@user = User.find(params[:id])
		@title = "Edit user"
	end
	
	def update
		# @user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			@title = "Edit user"
			render "edit"
		end
	end
	
	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_path
	end
	
	
	private
	
		def authenticate
			deny_access unless signed_in?
		end
		
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		
		def admin_user
			# @user = User.find(params[:id])
			redirect_to root_path unless current_user.admin?
			
			# admin user shold not be able to destroy themselves
			#@user = User.find(params[:id])
			#if current_user?(@user)
			#	flash[:notice] = "Admin user can not delete themselves"
			#	redirect_to(root_path)
			#end
		end
		def signed_in_user
			# redirect to root if user is signed in
			# redirect_to root_path unless !signed_in?
			redirect_to root_path if signed_in?
		end
end

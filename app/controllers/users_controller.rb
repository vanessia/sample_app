class UsersController < ApplicationController
  before_filter :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: :destroy

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
  	@user = User.new(params[:user]) 
  	#equivalent to@user = User.new(name: "Foo Bar", email: "foo@invalid" ...)
  	
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    # form_for automatically knows use to use put (hidden in input field in html) if User.first.new_record? returns false

    #   @user = User.find(params[:id]) // since defined in correct_user already
    
  end

  def update
    #   @user = User.find(params[:id]) // since defined in correct_user already

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in" unless signed_in?
      # same as flash[:notice] = "Please sign in" redirect_to signin_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  
end

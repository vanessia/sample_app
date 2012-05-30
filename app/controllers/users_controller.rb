class UsersController < ApplicationController
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

end

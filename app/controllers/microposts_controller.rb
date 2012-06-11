class MicropostsController < ApplicationController
	before_filter :signed_in_user, 	only: [:create, :destroy]
	before_filter :correct_user, 		only: :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_path
		else
			@feed_items=[] #takes care of invalid micropost entries
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		redirect_to root_path
	end

	private

	def correct_user
		#current_user.microposts.find... b/c safer to find posts via user association
		#we use find_by_id instead of find because the latter raises an exception when the micropost doesn’t exist instead of returning nil
		@micropost = current_user.microposts.find_by_id(params[:id]) 
		redirect_to root_path if @micropost.nil?
	end

end
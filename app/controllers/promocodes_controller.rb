class PromocodesController < ApplicationController

	def new
	end

	def create
		@user = User.find(params[:user_id][:id])
		@user.give_service(params[:service_type],params[:count].to_i)
		#UserMailer.give_service_notification(@user.email,params[:service_type],params[:count]).deliver_now
		redirect_to root_path
	end

end

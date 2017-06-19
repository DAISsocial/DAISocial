class CheckRequestsController < ApplicationController
	before_action :major

	def new
		@check_request = CheckRequest.new
	end

	def create
		params[:check_request][:center][0] = params[:check_request][:center][0].to_f
		params[:check_request][:center][1] = params[:check_request][:center][1].to_f
		current_user.spend_service("check_request")
		@result = HTTParty.post(
        "http://#{Rails.application.config.analysis_app_host}:#{Rails.application.config.analysis_app_port}"\
							"/users/#{current_user.id}/check_request",
				{
						:body => params[:check_request].to_json,
						:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        }
		)

		redirect_to root_path
		# params[:user_id] = current_user.id[:id]
		# render "static_pages/home"
  end

	private

 	def major
 		redirect_to(root_url) unless current_user.have_service?("check_request")
  end

end

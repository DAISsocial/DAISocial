class SearchRequestsController < ApplicationController
	before_action :major
	def new
		@search_request = SearchRequest.new
	end

	def create
		params[:search_request][:center][0] = params[:search_request][:center][0].to_f
		params[:search_request][:center][1] = params[:search_request][:center][1].to_f
		params[:search_request][:radius] = params[:search_request][:radius].to_i/100
		current_user.spend_service("search_request")
		@result = HTTParty.post("http://0.0.0.0:8080/users/#{current_user.id}/search_request",
		{ 
		    :body => params[:search_request].to_json,
		    :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
		})
		
		redirect_to root_path
	end
	private
 	def major
 		redirect_to(root_url) unless current_user.have_service?("search_request")
 	end
end

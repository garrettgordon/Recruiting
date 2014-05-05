class SearchController < ApplicationController
	def index
		#@results = PgSearch.multisearch(params[:search])
		@orgs = Organization.text_search(params[:search])
		@jobs = Job.text_search(params[:search])
		@users = User.text_search(params[:search])
		@events = Event.text_search(params[:search])
	end
end

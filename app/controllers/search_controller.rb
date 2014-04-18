class SearchController < ApplicationController
	def index
		#@results = PgSearch.multisearch(params[:search])
		@orgs = Organization.text_search(params[:search])
		organizations=Organization.readySort(@organizations)
    organizations=Organization.mergeSort(organizations)
    @orgs=Organization.listConvert(organizations)
		@jobs = Job.text_search(params[:search])
		@users = User.text_search(params[:search])
	end
end

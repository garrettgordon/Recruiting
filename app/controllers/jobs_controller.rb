class JobsController < ApplicationController
	before_action :set_job, only: [:show, :update, :delete]
	def index
		@jobs = Job.tag_search(params[:search])
	end

	def new
		@job = Job.new
	end

	def show

	end

	def create
		@job = Job.new(job_params)
		@job.skill_list = job_params[:skill_list]
		respond_to do |format|
			if @job.save
				current_user.organizations.first.jobs << @job
				format.html { redirect_to @job, notice: 'Job was succesfully created' }
				format.json { render action: 'show', status: :created, location:@job }
			else
				format.html { render action: 'new' }
				format.json { render json: @job.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
	end

	def delete
	end

	private 
		def set_job
			@job = Job.find(params[:id])
		end

		def job_params
			params.require(:job).permit(:title, :description, :skill_list)
		end

end

class JobsController < ApplicationController
	before_action :set_job, only: [:edit, :show, :update, :delete]
	def index
		@jobs = Job.text_search(params[:search])
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

	def edit
	end

	def update
		respond_to do |format|
			if @job.update(job_params)
				@job.skill_list = job_params[:skill_list]
				format.html { redirect_to @job, notice:'Successful update' }
				format.json { head :no_content}
			else
				format.html { render action: 'edit' }
				format.html { render json: @job.errors, status: :unprocessable_entity}
			end
		end
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

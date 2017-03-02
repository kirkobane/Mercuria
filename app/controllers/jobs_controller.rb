class JobsController < ApplicationController
	def index
		@jobs = Job.all
		@users = User.all

		@job_current_user = Job.first.user.first_name
	end
	def create
		@job = current_user.jobs.create(job_params)
			if @job
				flash[:notice] = "Your Job was successfully created"
				redirect_to @job
			else
				flash[:alert] = "There was a problem saving your job"
				redirect_to new_job_path
			end

	end
	def show
		@job = Job.find(params[:id])
		@job_user = @job.user 
	end
	def new
		@job = Job.new	
		

		@job.user_id = params[:current_user_id]
		@job.origin = params['origin']
		@job.destination = params['destination']
		@job.cost = params['cost']
		@job.containers = params['containers']

		@job.save
	end

	private

	def job_params
		params.require(:job).permit(:origin, :destination, :cost, :containers)
	end
end
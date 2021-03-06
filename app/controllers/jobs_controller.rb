class JobsController < ApplicationController

	def index
		
		@users = User.all
		@boat_jobs = BoatJob.all
		@boat_job = BoatJob.new
		@job_current_user = Job.first.user.first_name
		@boat = Boat.find(1)
		@boats = [@boat]

	end
	
	def create
		job_params[:cost] = job_params[:cost].delete!("$").delete!(",").to_f

		@job = current_user.jobs.new(job_params)
			if @job.save
				flash[:notice] = "Your Job was successfully created"
				redirect_to @job
			else
				flash[:alert] = "There was a problem saving your job"
				render new_job_path
			end
	end
	
	def show
		@job = Job.find(params[:id])
		@job_user = @job.user 
		@boat_job = BoatJob.new
		@boat_jobs=BoatJob.all
		@jobs = [@job]
	end

	def new
		@job = Job.new		
	end

	def edit
		@job = Job.find(params[:id])
	end

	def update
		job = Job.find(params[:id])
		job.update_attributes(job_params)
		redirect_to job
	end

	def destroy
		Job.find(params[:id]).destroy
		flash[:notice] = "Your job was deleted successfully"
		redirect_to :back
	end

	private

	def job_params
		params.require(:job).permit(:name, :origin, :destination, :cost, :containers, :description)
	end
end

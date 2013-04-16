class JobsController < ApplicationController
  def index
    query = (params[:query])
    location = (params[:location])
    
    @recent_jobs = Jobs.jobs_since
    @pull_jobs = Jobs.pull_jobs(query, location)
    @ruby_jobs = Jobs.recent_jobs('ruby').size
    @rails_jobs = Jobs.recent_jobs('rails').size
    @admin_jobs = Jobs.recent_jobs('admin').size
  end
end

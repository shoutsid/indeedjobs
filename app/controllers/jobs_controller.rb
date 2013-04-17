class JobsController < ApplicationController
	include JobsHelper
  def index
    query = (params[:query])
    location = (params[:location])
      
    @pull_jobs = Jobs.pull_jobs(query, location)
    set_variables

  end
end

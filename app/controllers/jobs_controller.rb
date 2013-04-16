class JobsController < ApplicationController
  def index
    @jobs = Jobs.recent.order('posted desc')
    @pull_jobs = Jobs.pull_jobs(params[:search]) 
  end
end

class JobsController < ApplicationController
  include JobsHelper
  def index
    query = (params[:query])
    location = (params[:location])
    country = (params[:country])
    radius = (params[:radius])

    @pull_jobs = Jobs.pull_jobs(query, location, country, radius)
    variables

    respond_to do |format|
      format.html
      format.xlsx { send_data Jobs.to_xlsx.to_stream.read, filename: "jobs-#{Time.now}.xlsx" }
    end

  end
end

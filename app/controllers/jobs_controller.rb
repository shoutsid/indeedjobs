class JobsController < ApplicationController
  def index
    @jobs = Jobs.all(order: "posted desc") 
  end
end

class JobsController < ApplicationController
  def index
    @jobs = Jobs.recent.order('posted desc')
  end
end

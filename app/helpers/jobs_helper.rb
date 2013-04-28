module JobsHelper
  def variables
    jobtypes = [ 'ruby', 'rails', 'admin' ]
    since = ['1 week', '2 weeks', '1 month']
    since.each { |s| set_variables(jobtypes, s) }
    @total_recent_jobs = Jobs.all_jobs_since.page(params[:page]).per(10)
  end

  private
  def set_variables(jobtypes, since)
    since = since.parameterize('_')
    jobtypes.each { |jobtype| instance_variable_set("@#{jobtype}_jobs_#{since}", Jobs.jobs(jobtype, since_set(since))) } 
    instance_variable_set("@total_jobs_#{since}", Jobs.all_jobs_since(since_set(since)))
  end
  
  def since_set(since)
    case since
    when 'recent','7_days','1_week'
      7.days.ago
    when '14_days','2_weeks'
      2.weeks.ago
    when '1_month'
      1.month.ago
    end
  end
end

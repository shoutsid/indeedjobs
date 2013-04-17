module JobsHelper
	def set_variables
		jobtypes = [ 'ruby', 'rails', 'admin' ]


		jobtypes.each { |jobtype| instance_variable_set("@recent_#{jobtype}_jobs", Jobs.jobs(jobtype, 7.days.ago).count) } 
		jobtypes.each { |jobtype| instance_variable_set("@recent_percent_is_#{jobtype}", Jobs.percent_of_jobtype_since(jobtype, 7.days.ago)) } 
		@total_recent_jobs = Jobs.all_jobs_since
		@recent_percent_is_other = 100 - @recent_percent_is_ruby - @recent_percent_is_rails - @recent_percent_is_admin


		jobtypes.each { |jobtype| instance_variable_set("@days14_#{jobtype}_jobs", Jobs.jobs(jobtype, 14.days.ago).count) } 
		jobtypes.each { |jobtype| instance_variable_set("@days14_percent_is_#{jobtype}", Jobs.percent_of_jobtype_since(jobtype, 14.days.ago)) } 
		@days14_total_jobs= Jobs.all_jobs_since(14.days.ago).count
		@days14_percent_is_other = 100 - @days14_percent_is_ruby - @days14_percent_is_rails - @days14_percent_is_admin


		jobtypes.each { |jobtype| instance_variable_set("@month1_#{jobtype}_jobs", Jobs.jobs(jobtype, 1.month.ago).count) } 
		jobtypes.each { |jobtype| instance_variable_set("@month1_percent_is_#{jobtype}", Jobs.percent_of_jobtype_since(jobtype, 1.month.ago)) } 
		@month1_total_jobs= Jobs.all_jobs_since(1.month.ago).count
		@month1_percent_is_other = 100 - @month1_percent_is_ruby - @month1_percent_is_rails - @month1_percent_is_admin

	end
end

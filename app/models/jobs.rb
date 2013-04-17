require 'indeed'
require 'open-uri'
class Jobs < ActiveRecord::Base
	attr_accessible :city, :company, :description, :expired, :jobtitle, :posted, :radius, :url, :job_key

	def self.jobs(job, since=7.days.ago)
		all_jobs_since(since).where('description ILIKE ? OR jobtitle ILIKE ?', "%#{job}%", "%#{job}%")
	end

	def self.all_jobs_since(since=7.days.ago)
		where('posted > ?', since).order('posted desc') 
	end

	def self.percent_of_jobtype_since(job, since)
		result = jobs(job, since).size.to_f / all_jobs_since(since).size.to_f * 100.0
	end

	def self.tinyurl(url)
		tinyurl = open('http://tinyurl.com/api-create.php?url=' + url).read
	end

	def self.pull_jobs(query, location='horden')
		a = Indeed::Client.new(3095480858445677)
		params = {
			q: "#{query}",
			l: "#{location}",
			co: 'gb',
			radius: '50',
			limit: '1000',
			userip: '0.0.0.0',
			useragent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)',
		}
		search = a.search(params)
		search["results"].each do |job|
			unless exists?(job_key: job["jobkey"])
				create!(
					jobtitle: job["jobtitle"],
					city: job["city"],
					company: job["company"],
					description: job["snippet"],
					url: tinyurl(job["url"]),
					posted: job["date"],
					expired: job["expired"],
					job_key: job["jobkey"]


				)
			end
		end
	end

end

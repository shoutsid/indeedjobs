require 'indeed'
require 'open-uri'
class Jobs < ActiveRecord::Base
  attr_accessible :city, :company, :description, :expired, :jobtitle, :posted, :radius, :url, :job_key

  acts_as_xlsx

  def self.jobs(job, since=7.days.ago)
    all_jobs_since(since).where('description ILIKE ? OR jobtitle ILIKE ?', "%#{job}%", "%#{job}%")
  end

  def self.all_jobs_since(since=7.days.ago)
    where('posted > ?', since).order('posted desc')
  end

  def self.percent_of_jobtype_since(job, since)
    jobs(job, since).size.to_f / all_jobs_since(since).size.to_f * 100.0
  end

  def self.pull_jobs(query, location, country, radius)
    indeed = Indeed::Client.new(3095480858445677)

    search = indeed.search(params(query, location, country, radius))
    search["results"].each {|job| save_job(job) unless exists?(job_key: job["jobkey"])}
  end

  private
  def self.params(query, location, country, radius)
    {
      q: query,
      l: location,
      co: country(country),
      radius: radius,
      limit: '1000',
      userip: '0.0.0.0',
      useragent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)'
    }
  end

  def self.country(country)
    case country
    when 'England'
      'gb'
    when 'United States'
      'us'
    when 'Canada'
      'ca'
    when 'Australia'
      'au'
    end
  end

  def self.save_job(job)
    create!(
      jobtitle: job["jobtitle"], city: job["city"], company: job["company"], description: job["snippet"],
      url: tinyurl(job["url"]), posted: job["date"], expired: job["expired"], job_key: job["jobkey"]
    )
  end

  def self.tinyurl(url)
    tinyurl = open('http://tinyurl.com/api-create.php?url=' + url).read
  end
end

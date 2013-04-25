require 'spec_helper'

describe Jobs do

  describe '#all_jobs_since' do
    it 'should return all jobs since a given date' do
      job = Jobs.create!(jobtitle: 'foo', company: 'bar', description: 'foo job', posted: Date.today)

      Jobs.all_jobs_since(7.days.ago).should == [job]
    end

    it 'return empty array if no jobs found' do
      Jobs.all_jobs_since(7.days.ago).should == []
    end
  end

  describe '#percent_of_jobtype_since' do
    it 'returns percentage of given jobtype in a given time frame' do
      job = Jobs.create!(jobtitle: 'foo', company: 'bar', description: 'foo job', posted: Date.today)
      Jobs.percent_of_jobtype_since('foo', 7.days.ago).should == 100
    end
  end

  describe '#params' do
    it 'should return corrrect params' do
      Jobs.params('foo', 'bar', 'England', 15).should ==  {q: 'foo', l: 'bar', co: 'gb', radius: 15, limit: '1000', userip: '0.0.0.0', useragent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)'}
    end
  end

  describe '#country' do
    it 'should return correct country code' do
      Jobs.country('United States').should == 'us'
    end
  end

  describe '#save_job' do
    it 'should create job in the database when suppied with parsed json' do
      job = {"jobtitle"=>"Junior Software Developer", "company"=>"Catalyst", "city"=>"Newcastle upon Tyne", "state"=>"ENG", "country"=>"GB", "formattedLocation"=>"Newcastle upon Tyne", "source"=>"reed.co.uk", "date"=>"Sun, 21 Apr 2013 13:20:57 GMT", "snippet"=>"programming languages such as Java, Python, or <b>Ruby</b> Practical knowledge of MVC frameworks CFWheels, <b>Ruby</b> on Rails, CakePHP, CodeIgniter Django, Spring etc... ", "url"=>"http://www.indeed.co.uk/viewjob?jk=905481c47edfe1ef&qd=mIeboGGLyWYFwwb49cg0Jke81mv6vZLFxa4-QaeuJ4PHlwbzehPBKjbA58HSXo57eM_ZDgqWR2xHbCol0GtuTR6nojn63AzuMLy1372sZMY&indpubnum=3095480858445677&atk=17p0u5mrg0mq11ik", "onmousedown"=>"indeed_clk(this, '6391');", "jobkey"=>"905481c47edfe1ef", "sponsored"=>false, "expired"=>false, "formattedLocationFull"=>"Newcastle upon Tyne", "formattedRelativeTime"=>"4 days ago"}
      lambda{ Jobs.save_job(job)}.should change{ Jobs.count }.by(1)
    end
  end
  
  describe '#tinyurl' do
    it 'should convert a url to a tinyurl' do
      url = 'http://www.pointblankcoder.com'
      Jobs.tinyurl(url).should include('http://tinyurl.com/')
    end
  end

end

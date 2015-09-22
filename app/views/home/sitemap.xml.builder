xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc "https://www.wehirefitness.com"
    xml.priority 1.0
  end

  @jobs.each do |job|
    xml.url do
      xml.loc job_url(job)
      xml.priority 0.9
    end
  end
end
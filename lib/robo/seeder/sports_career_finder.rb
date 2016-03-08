module Robo
  module Seeder
    class SportsCareerFinder < Robo::Seeder::Base
      def self.process
        base_url = 'http://www.sportscareerfinder.com/members/jobs/category/'
        categories = [
          { url: 'strength-conditioning', category: 1},
          { url: 'heath-fitness', category: 1 }

        ]

        new_job_ids = []
        categories.each do |cat|
          cat_doc = Nokogiri::HTML(open(base_url + cat[:url]))
          whf_category = Category.find(cat[:category])
          jobs = cat_doc.css('.content-center .wpjb-col-title').map{ |element| element.css('a').first['href'] }

          jobs.each do |job_url|
            next if new_job_ids.count > 3
            job_doc = Nokogiri::HTML(open(job_url))
            origin_uid = job_doc.css('body').first['class'].to_s[/postid\-.*/]
            address = job_doc.css('.wpjb-icon-location a').first.content
            next unless address.split(/\,/).count == 2 && address.split(/\,/)[1].length == 2
            company_url = job_doc.css('.wpjb-top-header-title a').first['href']
            company_name = job_doc.css('.wpjb-top-header-title').first.content
            company_description = "Check out <a href='#{company_url}' target='_blank'>the website</a> to learn more!"
            if /sportscareerfinder/.match(company_url)
              company_doc = Nokogiri::HTML(open(company_url))
              company_url = company_doc.css('.wpjb-icon-link-ext-alt a').first['href']
              company_description = company_doc.css('.wpjb-text').first.content
            end

            title = job_doc.css('.entry-title').first.content
            description = job_doc.css('.wpjb-text-box .wpjb-text').first.to_s.gsub(/<\/?div[^>]*>/,"")
            address = job_doc.css('.wpjb-icon-location a').first.content
            city = address.split(/\,/)[0]
            state = address.split(/\,/)[1]

            job_hash = {
              origin_uid: origin_uid,
              title: title,
              description: description,
              company_description: company_description,
              company_email: "NA",
              company_name: company_name.strip,
              company_url: company_url,
              city: city,
              state: state,
              zip: '-1',
              how_to_apply: "Apply at our <a href='#{company_url}' target='_blank'>website.</a>",
              category: cat[:category],
              published: true
            }

            job = Job.new(job_hash)

            if job.save
              new_job_ids << job.id
            end
          end
        end

        return new_job_ids
      end
    end
  end
end

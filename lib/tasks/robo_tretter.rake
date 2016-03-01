require 'nokogiri'
require 'open-uri'

namespace :whf do
  namespace :robo_tretter do
    task :seed => :environment do
      SlackModule::API::robo_tretter_says("_beep_ Starting seed process _boop_")

      base_url = 'http://www.fitnessjobs.com/employment/'
      categories = [
        { url: 'sales-browse-1170.aspx', category: 3 },
        { url: 'personal-trainer-browse-1107.aspx', category: 1  },
        { url: 'fitness-specialist-browse-1027.aspx', category: 1 },
        { url: 'exercise-physiology-browse-1020.aspx', category: 1 },
        { url: 'fitness-manager-listing-47035.aspx', category: 2 },
        { url: 'personal-training-manager-browse-1109.aspx', category: 2} ,
        { url: 'fitness-director-browse-1023.aspx', category: 2 },
        { url: 'membership-rep-browse-1081.aspx', category: 5 },
        { url: 'operations-browse-1097.aspx', category: 5 },
        { url: 'front-desk-staff-browse-1035.aspx', category: 5 }
      ]

      processed_count = 0

      categories.each do |cat|
        cat_doc = Nokogiri::HTML(open(base_url + cat[:url]))
        whf_category = Category.find(cat[:category])
        jobs = cat_doc.css('.intTBL').map{ |element| {url: element.css('a').first['href'], company: element.css('td')[1].content} }

        SlackModule::API::robo_tretter_says("Scanning #{base_url}#{cat[:url]} for new #{whf_category.name} jobs")

        jobs.each do |job|
          job_doc = Nokogiri::HTML(open(base_url + job[:url]))
          address = job_doc.css('#ctl01_PageContent_CityStatePostal').first.content
          state = /, (..)/.match(address)[1]
          title = job_doc.css('.h1DBL').first.content

          next unless job_doc.css('#ctl01_PageContent_ListingDisplayIcons_VisitWebSiteLink').first.present?

          company_url = URI.unescape(job_doc.css('#ctl01_PageContent_ListingDisplayIcons_VisitWebSiteLink').first['href'])
          job_hash = {
            origin_uid: job_doc.css('form').first['action'].to_s[/\=.*/],
            title: title,
            description: job_doc.css('#ctl01_PageContent_TabC_Tab_Description_JobDescription').first.to_s.gsub(/<\/?span[^>]*>/,""),
            company_description: "Check out <a href='#{company_url}' target='_blank'>our website</a> to learn more!",
            company_email: "NA",
            company_name: job[:company],
            company_url: company_url,
            city: address[/^[^\,]*/],
            state: state,
            zip: /#{Regexp.quote(state)} (.*)/.match(address)[1],
            how_to_apply: "Apply at our <a href='#{company_url}' target='_blank'>website.</a>",
            category: cat[:category],
            published: true
          }
          job_hash[:origin_uid].slice!(0)
          job = Job.new(job_hash)

          if job.save
            processed_count += 1
          end
        end
      end

      SlackModule::API::robo_tretter_says("_whrrrrrr_ Seed process completed.  I have added *#{processed_count}* new jobs.")
    end
  end
end

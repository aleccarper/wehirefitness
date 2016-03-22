module Robo

  module Seeder

    class UFCGym < Robo::Seeder::Base

      def self.process
        new_job_ids = []

        category_keys = {
          'Facilities' => 6,
          'Fitness' => 1,
          'Front Desk' => 5,
          'Group Fitness' => 1,
          'Human Resources' => 5,
          'Management' => 2,
          'Marketing' => 3,
          'Operations' => 5,
          'Retail / Arm Bar' => 6,
          'Sales' => 3
        }

        root_doc = Nokogiri::HTML(open('http://ufcgym.hrmdirect.com/employment/job-openings.php?search=true&group=dept&'))
        root_doc.css('.reqResult').css('a').to_a.shuffle.each do |job_node|
          next if new_job_ids.count > 8
          job_url = "http://ufcgym.hrmdirect.com/employment/#{job_node['href']}"
          job_doc = Nokogiri::HTML(open(job_url))
          origin_uid = job_url[/req\=.*/]
          their_title = job_doc.css('h2').first.content
          their_category = job_doc.css('.reqResult table tr .viewFieldValue')[0].content
          thier_address = job_doc.css('.reqResult table tr .viewFieldValue')[1].content

          next unless thier_address.split(/\,/).count == 2 && thier_address.split(/\, /)[1].length == 2

          company_url = job_url
          company_name = 'UFC Gym'
          company_description = "Check out <a href='#{company_url}' target='_blank'>the website</a> to learn more!"

          p1 = their_title.index("(")
          p2 = their_title.index(")")

          next unless p1 && p2

          title = their_title
          title[p1-1..p2] = ""
          description = job_doc.css('.jobDesc').first
          city = thier_address.split(/\,/)[0]
          state = thier_address.split(/\,/)[1]

          job_hash = {
            origin_uid: origin_uid,
            title: title,
            description: description,
            company_description: company_description,
            company_email: "NA",
            company_name: company_name,
            company_url: company_url,
            city: city,
            state: state,
            zip: '-1',
            how_to_apply: "Apply at our <a href='#{company_url}' target='_blank'>website.</a>",
            category: category_keys[their_category],
            published: true
          }

          job = Job.new(job_hash)

          if job.save
            new_job_ids << job.id
          end
        end # each job

        return new_job_ids
      end # def self.process

    end # class UFCGym
  end

end

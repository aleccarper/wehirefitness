require 'nokogiri'
require 'open-uri'
include Rails.application.routes.url_helpers

module Robo
  class Tretter
    def self.seed
      seeders = [
        Robo::Seeder::FitnessJobs
      ]

      notify("_beep_ Starting seed process _boop_")
      new_job_ids = seeders.map(&:process).flatten
      notify("_whrrrrrr_ Seed process completed.  I have added *#{new_job_ids.count}* new jobs.")
      queue_spew(new_job_ids)
    end

    def self.notify(message)
      SlackModule::API::robo_tretter_says(message)
    end

    private

    def self.queue_spew(job_ids)
      workers_queued = 0
      job_ids.sample(12).each_with_index do |id, index|
        job = Job.find(id)
        next unless job
        category = Category.find(job.category)
        message = "Apply for this new ##{category.name.downcase.gsub(/\s+/, '')} job at #{job_url(job)}"
        Worker::Spew.perform_in(index.hours, message)
        workers_queued += 1
      end

      notify("I have queued *#{workers_queued}* tweets.")
    end
  end
end

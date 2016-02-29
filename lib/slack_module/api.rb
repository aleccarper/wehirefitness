require 'slack-notifier'
require 'active_support/core_ext/integer/inflections'

module SlackModule

  class API

    def self.notify_new_job_posting(url, job_title)
      msg = "*New Job Posting* #{job_title}\n"
      msg << "\tCheck it out here: #{url}\n"
      msg << "\t@tretter @alec\n"
      self.notify msg
    end

    def self.notify_robo_tretter_seed_done(processed_count)
      msg = "robo_tretter: I just added *#{processed_count}* new job postings\n"
      msg << "robo_tretter: _beep_ *boop* _beep_"
      self.notify msg
    end

    def self.notify(message, attachments=nil)
      slack = Slack::Notifier.new(
        ENV['SLACK_WEBHOOK_URL'],
        channel: '#general',
        username: "wehirefitness-#{Rails.env}"
      )
      if attachments
        slack.ping message, attachments: attachments
      else
        slack.ping message
      end
    end

  end

end

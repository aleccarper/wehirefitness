class JobMailer < ActionMailer::Base
  layout 'mailer'
  default from: "support@wehirefitness.com", from_name: "We Hire Fitness"

	def new_job_receipt(job, charge)
		@job = job
		@charge = charge

		mail(to: @job.company_email, subject: "Your #{@job.title} job has been posted!")
	end

  def new_job(job)
		@job = job

		mail(to: @job.company_email, subject: "Your #{@job.title} job has been created!")
	end
end

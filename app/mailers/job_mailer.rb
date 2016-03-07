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

  def new_job_admin_notification(job)
    @job = job

    mail(to: 'jobs@wehirefitness.com, xarious@gmail.com, setretter@gmail.com', subject: "A job has been posted")
  end
end

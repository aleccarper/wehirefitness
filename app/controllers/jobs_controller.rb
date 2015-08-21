class JobsController < ApplicationController

	def show
		@job = Job.find_by_id(params[:id])
	end

	def new
		@job = Job.new(session[:job])
	end

	def review
		if(params[:job] || session[:job])
			if(params[:job])
				session[:job] = job_params
			end

			@job = Job.new(session[:job])
			@category = Category.find_by_id(@job.category)
		else
			redirect_to jobs_new_path
		end
	end

	def purchase

	end

	def complete_purchase

		begin
		  customer = Stripe::Customer.create(
		    :email => session[:job][:company_email],
		    :card  => params[:stripeToken]
		  )

		  charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => 2500,
		    :description => 'wehirefitness.com Job Posting',
		    :currency    => 'usd'
		  )

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  return redirect_to jobs_complete_purchase_path
		end

		@job = Job.new(session[:job])
		@job.stripe_customer_id = customer.id
		@job.stripe_charge_id = charge.id
		@job.save

		session[:job] = nil
		flash[:notice] = 'Your job has been posted!'

		JobMailer.new_job_receipt(@job, charge).deliver

		redirect_to jobs_thank_you_path
	end

	def thank_you

	end

  private

  def job_params
    params.require(:job).permit(:title, :category, :city, :state, :zip, :description, :how_to_apply, :company_description, :company_name, :company_url, :company_email )
  end
end

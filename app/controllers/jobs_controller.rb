class JobsController < ApplicationController

	def new
		@job = Job.new
	end

	def review
		if(params[:job] || session[:job])
			if(params[:job])
				session[:job] = job_params
			end

			@job = Job.new(session[:job])
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
		    :description => 'We Hire Fitness Job Posting',
		    :currency    => 'usd'
		  )

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  return redirect_to jobs_complete_purchase_path
		end

		@job = Job.create(session[:job])
		session[:job] = nil
		flash[:notice] = 'Your job has been posted!'
		redirect_to root_path
	end

  private

  def job_params
    params.require(:job).permit(:title, :category, :city, :state, :zip, :description, :how_to_apply, :company_description, :company_name, :company_url, :company_email )
  end
end

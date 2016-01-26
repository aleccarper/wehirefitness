class JobsController < ApplicationController

	def show
		if current_admin
			@job = Job.find_by_id(params[:id])
		else
			@job = Job.visible.find_by_id(params[:id])
		end

    if @job
      set_meta_tags :title => @job.title + " at " + @job.company_name
    else
      set_meta_tags :title => "Job not found"
    end
	end

	def new
		@job = Job.new(session[:job])
    set_meta_tags :title => "Describe your job listing"
	end

	def review
		if(params[:job] || session[:job])
      set_meta_tags :title => "Review your job listing"

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
    set_meta_tags :title => "Almost there..."
	end

	def publish
		if !current_admin
			redirect_to root_path
		end

		@job = Job.find_by_id(params[:id])
		@job.published = true
		@job.save

		redirect_to action: "show", id: @job.id
	end

	def unpublish
		if !current_admin
			redirect_to root_path
		end

		@job = Job.find_by_id(params[:id])
		@job.published = false
		@job.save

		redirect_to action: "show", id: @job.id
	end

	def charge_and_publish
		if !current_admin
			redirect_to root_path
		end

		@job = Job.find_by_id(params[:id])

		begin
			charge = Stripe::Charge.create(
		    :customer    => @job.stripe_customer_id,
		    :amount      => 2500,
		    :description => 'wehirefitness.com Job Posting',
		    :currency    => 'usd'
		  )
		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  return redirect_to action: "show", id: @job.id
		end

		@job.stripe_charge_id = charge.id
		@job.published = true
		@job.save

		JobMailer.new_job_receipt(@job, charge).deliver

		redirect_to action: "show", id: @job.id
	end

	def complete_purchase
		if current_admin
			redirect_to jobs_thank_you_path

			@job = Job.new(session[:job])
			@job.stripe_charge_id = 'admin_job_posting'
			@job.published = true
			@job.save

			session[:job] = nil
			flash[:notice] = 'Your job has been posted!'
			return
		end

		begin
		  customer = Stripe::Customer.create(
		    :email => session[:job][:company_email],
		    :card  => params[:stripeToken]
		  )
		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  return redirect_to jobs_complete_purchase_path
		end

		@job = Job.new(session[:job])
		@job.stripe_customer_id = customer.id
		@job.save

		session[:job] = nil
		flash[:notice] = 'Your job has been posted!'

    SlackModule::API::notify_new_job_posting("https://www.wehirefitness.com#{job_path(@job)}", @job.title)

		redirect_to jobs_thank_you_path
	end

	def thank_you
    set_meta_tags :title => "Your job has been posted!"
	end

  private

  def job_params
    params.require(:job).permit(:title, :category, :city, :state, :zip, :description, :how_to_apply, :company_description, :company_name, :company_url, :company_email )
  end
end

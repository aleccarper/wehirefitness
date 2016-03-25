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
		response = @job.charge_and_publish

		if !response[:success]
			flash[:error] = response[:message]
		  return redirect_to action: "show", id: @job.id
		end

		redirect_to action: "show", id: @job.id
	end

	def complete_purchase
		@job = Job.new(session[:job])

		if current_admin
			@job = Job.new(session[:job])
			@job.stripe_charge_id = 'admin_job_posting'
			@job.published = true
			if @job.save
				session[:job] = nil
				flash[:notice] = 'Admin - job has been publisehd'
				return redirect_to jobs_thank_you_path
			end
			flash[:error] = @job.errors.full_messages
			return redirect_to jobs_purchase_path
		end

		if !@job.valid?
			flash[:error] = @job.errors.full_messages
			return redirect_to jobs_purchase_path
		end

		begin
		  customer = Stripe::Customer.create(
		    :email => session[:job][:company_email],
		    :card  => params[:stripeToken]
		  )
			@job.stripe_customer_id = customer.id
		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  return redirect_to jobs_purchase_path
		end

		if coupon_code = params[:coupon_code]
			coupon = Coupon.find_by_code(coupon_code)
			@job.coupon = coupon if coupon.present? && coupon.can_use?
		end

		if @job.save
			session[:job] = nil
			flash[:notice] = 'Your job has been created!'
	    SlackModule::API::notify_new_job_posting(job_url(@job), @job.title)
			JobMailer.new_job(@job).deliver_now
			JobMailer.new_job_admin_notification(@job).deliver_now
			return redirect_to jobs_thank_you_path
		end
		flash[:error] = @job.errors.full_messages
		return redirect_to jobs_purchase_path
	end

	def thank_you
    set_meta_tags :title => "Your job has been posted!"
	end

  private

  def job_params
    params.require(:job).permit(:title, :category, :city, :state, :zip, :description, :how_to_apply, :company_description, :company_name, :company_url, :company_email )
  end
end

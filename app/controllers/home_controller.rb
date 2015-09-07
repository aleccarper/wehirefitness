class HomeController < ApplicationController

	def index
		@jobs = {}
		Category.all.each  do |c|
			@jobs[c.name] = Job.where(category: c.id.to_s).visible
		end

		if current_admin
			@unpublished_jobs = Job.unpublished
		end
	end


end

class HomeController < ApplicationController

	def index
		@jobs = Job.order('created_at DESC').all
	end


end

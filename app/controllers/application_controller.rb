class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :force_www!

  protected

  def force_www!
    if Rails.env.production? and request.host[0..3] != "www."
      redirect_to "#{request.protocol}www.#{request.host_with_port}#{request.fullpath}", :status => 301
    end
  end

  before_filter :set_seo
  def set_seo
    set_meta_tags :site => "We Hire Fitness",
                  :title => "Get to work!",
                  :keywords => "",
                  :description => "Here at We Hire Fitness, our mission is to connect employers in the fitness industry with people who are passionate about health, happiness and fitness.",
                  :twitter => {
                    :card => "summary",
                    :site => "@wehirefitness",
                    :title => "We Hire Fitness | Get to work!",
                    :description => "Here at We Hire Fitness, our mission is to connect employers in the fitness industry with people who are passionate about health, happiness and fitness."
                  },
                  :og => {
                    :url => 'wehirefitness.com',
                    :title => "We Hire Fitness | Get to work!",
                    :description => 'Here at We Hire Fitness, our mission is to connect employers in the fitness industry with people who are passionate about health, happiness and fitness.',
                    :site_name => "We Hire Fitness",
                    :type => 'website'
                  }
  end
end

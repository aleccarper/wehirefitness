class LegalController < ApplicationController
	before_filter lambda { @body_class = 'page'; }

	def privacy_policy
		@page_title = 'Privacy Policy'
    set_meta_tags :title => "Privacy Policy"
	end

	def terms_and_conditions
		@page_title = 'Terms and Conditions'
    set_meta_tags :title => "Terms and Conditions"
	end
end

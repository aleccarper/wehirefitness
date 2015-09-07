class Job < ActiveRecord::Base
	validates :title, 
						:category, 
						:description, 
						:how_to_apply, 
						:company_description, 
						:company_name, 
						:company_url, 
						:company_email, 
						:zip, 
						:city, 
						:state, 
						presence: true

	geocoded_by 			:full_address
	before_save       :geocode
	after_validation 	:set_full_address, on: [:create, :update]

	def get_full_address
    [city, state, zip.to_s].reject(&:blank?).join(' ')
  end

  scope :visible, -> { where('published=? AND created_at > ?', true, 30.days.ago) }
  scope :unpublished, -> { where('published=? AND created_at > ?', false, 30.days.ago) }

  private

  def set_full_address
    self.full_address = get_full_address
  end	
end

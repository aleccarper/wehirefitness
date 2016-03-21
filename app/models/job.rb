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

	validates :origin_uid, uniqueness: true
	geocoded_by 			:full_address
	before_save       :geocode
	after_validation 	:set_full_address, on: [:create, :update]
	belongs_to :coupon

	def get_full_address
    [city, state, zip.to_s].reject(&:blank?).join(' ')
  end

  scope :visible, -> { where('published=? AND created_at > ?', true, 30.days.ago) }
  scope :unpublished, -> { where('published=? AND created_at > ?', false, 30.days.ago) }

	def charge_and_publish
		amount = 2500
		if self.coupon && self.coupon.can_use?
			amount = amount - (amount * self.coupon.as_float).round
		end

		if amount > 0
			begin
				charge = Stripe::Charge.create(
			    :customer    => self.stripe_customer_id,
			    :amount      => amount,
			    :description => 'wehirefitness.com Job Posting',
			    :currency    => 'usd'
			  )
			rescue Stripe::CardError => e
			  return {success: false, message: e.message}
			end

			self.stripe_charge_id = charge.id
		end

		self.published = true
		self.save

		JobMailer.new_job_receipt(self, charge).deliver_now

		return {success: true, amount_charged: amount}
	end

  private

  def set_full_address
    self.full_address = get_full_address
  end
end

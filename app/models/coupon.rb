class Coupon < ActiveRecord::Base
	validates :code,
						:percent_off,
						:max_uses,
						presence: true

	validates :code, uniqueness: true

  has_many :jobs

  def use
    self.uses = self.uses + 1
    self.save
    return true
  end

	def as_float
		[self.percent_off.to_f / 100, 1].min
	end

  def can_use?
    (self.max_uses > 0) ? (self.uses < self.max_uses) : true
  end
end

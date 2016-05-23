class Category < ActiveRecord::Base
  has_many :job_notifications
  has_many :seekers, through: :job_notifications

  def icon_url
    image_url("misc.png")
  end
end

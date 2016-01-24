class Category < ActiveRecord::Base
  has_many :job_notifications
  has_many :seekers, through: :job_notifications
end

class JobNotification < ActiveRecord::Base
  belongs_to :seeker
  belongs_to :category
end

class Seeker < ActiveRecord::Base
  validates :country,
            :city,
            :state,
            presence: true

  validates :email, uniqueness: true

  geocoded_by       :full_address
  before_save       :geocode
  after_validation  :set_full_address, on: [:create, :update]

  has_many :job_notifications, dependent: :destroy
  has_many :categories, through: :job_notifications
  accepts_nested_attributes_for :job_notifications
  def get_full_address
    [city, state, country].reject(&:blank?).join(' ')
  end

  private

  def set_full_address
    self.full_address = get_full_address
  end
end

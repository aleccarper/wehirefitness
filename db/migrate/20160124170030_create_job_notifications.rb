class CreateJobNotifications < ActiveRecord::Migration
  def change
    create_table :job_notifications do |t|
      t.belongs_to :seeker, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end

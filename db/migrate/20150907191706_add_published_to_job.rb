class AddPublishedToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :published, :boolean
  end
end

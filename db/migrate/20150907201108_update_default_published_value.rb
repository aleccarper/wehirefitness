class UpdateDefaultPublishedValue < ActiveRecord::Migration
	def up
	  change_column :jobs, :published, :boolean, default: false
	end

	def down
	  change_column :jobs, :published, :boolean, default: nil
	end
end

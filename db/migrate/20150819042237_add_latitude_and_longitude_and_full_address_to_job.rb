class AddLatitudeAndLongitudeAndFullAddressToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :latitude, :float
    add_column :jobs, :longitude, :float
    add_column :jobs, :full_address, :string
  end
end

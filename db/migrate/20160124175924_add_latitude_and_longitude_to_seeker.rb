class AddLatitudeAndLongitudeToSeeker < ActiveRecord::Migration
  def change
    add_column :seekers, :latitude, :float
    add_column :seekers, :longitude, :float
  end
end

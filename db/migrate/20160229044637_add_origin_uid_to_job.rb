class AddOriginUidToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :origin_uid, :string, :unique => true
  end
end

class AddCouponsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :coupon_id, :integer
  end
end

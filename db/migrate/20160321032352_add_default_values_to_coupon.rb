class AddDefaultValuesToCoupon < ActiveRecord::Migration
  def change
    change_column :coupons, :uses, :integer, default: 0
    change_column :coupons, :max_uses, :integer, default: 0
    change_column :coupons, :percent_off, :integer, default: 0
  end
end

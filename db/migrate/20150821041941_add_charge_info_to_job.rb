class AddChargeInfoToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :stripe_customer_id, :string
    add_column :jobs, :stripe_charge_id, :string
  end
end

class RemoveCustomerIdFromJob < ActiveRecord::Migration
  def change
  	remove_column :jobs, :customer_id
  end
end

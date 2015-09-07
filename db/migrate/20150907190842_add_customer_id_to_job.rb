class AddCustomerIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :customer_id, :string
  end
end

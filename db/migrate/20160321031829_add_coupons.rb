class AddCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :percent_off
      t.integer :max_uses
      t.integer :uses

      t.timestamps
    end
  end
end

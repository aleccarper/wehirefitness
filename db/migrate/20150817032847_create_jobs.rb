class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :category
      t.string :city
      t.string :state
      t.string :zip
      t.string :description
      t.string :how_to_apply
      t.string :company_description
      t.boolean :premium

      t.timestamps
    end
  end
end

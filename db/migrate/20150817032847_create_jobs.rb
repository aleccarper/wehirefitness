class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :category
      t.string :city
      t.string :state
      t.string :zip
      t.text :description
      t.text :how_to_apply
      t.text :company_description
      t.boolean :premium

      t.timestamps
    end
  end
end

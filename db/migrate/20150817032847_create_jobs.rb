class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :Title
      t.string :Category
      t.string :City
      t.string :State
      t.string :Zip
      t.string :Description
      t.string :HowToApply
      t.string :CompanyDescription
      t.boolean :Premium

      t.timestamps
    end
  end
end

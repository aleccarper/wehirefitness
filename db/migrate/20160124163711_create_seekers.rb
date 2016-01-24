class CreateSeekers < ActiveRecord::Migration
  def change
    create_table :seekers do |t|
      t.string :name
      t.string :email
      t.string :city
      t.string :state
      t.string :country, default: 'US'
      t.string :full_address, :string
      t.integer :radius

      t.timestamps
    end
    add_index :seekers, :email, unique: true
  end
end

class CreatePubs < ActiveRecord::Migration
  def change
    create_table :pubs do |t|
      t.string :name
      t.string :phone_number
      t.text :description
      t.timestamps null: false
    end
  end
end

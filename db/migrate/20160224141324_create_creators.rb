class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end

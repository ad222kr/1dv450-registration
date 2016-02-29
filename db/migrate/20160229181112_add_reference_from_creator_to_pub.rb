class AddReferenceFromCreatorToPub < ActiveRecord::Migration
  def change
    add_reference :pubs, :creator, index: true
  end
end

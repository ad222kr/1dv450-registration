class AddPositionReferenceToPub < ActiveRecord::Migration
  def change
    add_reference :pubs, :position, index: true
  end
end

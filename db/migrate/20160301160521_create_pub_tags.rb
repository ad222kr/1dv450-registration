class CreatePubTags < ActiveRecord::Migration
  def change
    create_table :pubs_tags do |t|
      t.belongs_to :pub, index: true
      t.belongs_to :tag, index: true
    end
  end
end

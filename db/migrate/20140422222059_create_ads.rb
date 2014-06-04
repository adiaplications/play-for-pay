class CreateAds < ActiveRecord::Migration
  def up
    create_table :ads do |t|
      t.integer "campaign_id"
      t.string "country", :default => "", :null => false
      t.decimal "price", :precision => 4, :scale => 2, :null => false
      t.string "link_url", :default => "", :null => false
      t.timestamps
    end
    add_index("ads", "campaign_id")
    add_index("ads", "country")
  end

  def down
    drop_table :ads
  end
end

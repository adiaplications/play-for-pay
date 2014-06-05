class CreateCampaigns < ActiveRecord::Migration
  def up
    create_table :campaigns do |t|
      t.string "company", :limit => 30, :default => "Mobpartner", :null => false
      t.string "commision_type", :default => "CPI", :null => false
      t.string "name", :limit => 30, :default => "", :null => false
      t.string "image_url", :default => "", :null => false
      t.string "package_name", :default => "", :null => false
      t.string "package_type" , :default => "Game", :null => false
      t.boolean "active", :default => true
      t.decimal "min_sdk", :precision => 3, :scale => 2
      t.boolean "notifications", :default => false
      t.boolean "emailing", :default => false
      t.boolean "sms", :default => false
      t.text "instructions"
      t.timestamps
    end
    add_index("campaigns", "company")
    add_index("campaigns", "name")
  end

  def down
    drop_table :campaigns
  end

end

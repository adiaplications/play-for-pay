class CreateUserDownloads < ActiveRecord::Migration
  def up
    create_table :user_downloads do |t|
      t.integer "user_id", :null => false
      t.integer "campaign_id"
      t.string "os" , :default => "Android", :null => false
      t.decimal "earn_price", :precision => 4, :scale => 2, :null => false
      t.timestamps
    end
    add_index :user_downloads, [:user_id], :unique => false
    add_index :user_downloads, [:user_id,:campaign_id], :unique => true
  end

  def down
    drop_table :user_downloads
  end
end

class DeleteUsers < ActiveRecord::Migration
  def up
    create_table :users, :force => true do |t|
      t.string "email", :null => false
      t.string "password_digest"
      t.string "country"
      t.integer "number_of_downloads", :default => 0
      t.decimal "total_earnings", :precision => 4, :scale => 2, :default => 0.0
      t.boolean "active", :default => true
      t.datetime "created_on", :default => '0000-00-00 00:00:00', :null => false
      t.datetime "last_visited_at", :default => '0000-00-00 00:00:00', :null => false
      t.integer "failed_attempts", :default => 0
      t.datetime "last_faild_attempt", :default => '0000-00-00 00:00:00', :null => false
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end

  def down
    drop_table :users
  end
end

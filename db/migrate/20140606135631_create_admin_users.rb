class CreateAdminUsers < ActiveRecord::Migration
  def up
    create_table :admin_users do |t|
      t.column "username", :string, :limit => 25, :null => false
      t.column "password_digest", :string
      t.timestamps
    end
  end

  def down
    drop_table :admin_users
  end
end

class CreateServerInfos < ActiveRecord::Migration
  def change
    create_table :server_infos do |t|
      t.string :remote_ip, null: false, limit: 15
      t.string :remote_dns, null: true
      t.string :local_ip, unique: false, limit: 15
      t.string :local_dns, null: true

      t.timestamps null: false

      t.index :remote_ip, unique: true
    end
  end
end

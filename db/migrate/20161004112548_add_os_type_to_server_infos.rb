class AddOsTypeToServerInfos < ActiveRecord::Migration
  def change
    add_column :server_infos, :os_type, :string
  end
end

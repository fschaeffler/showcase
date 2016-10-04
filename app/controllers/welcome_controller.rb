class WelcomeController < ApplicationController
  def index
  	@server_info = ServerInfo.find_myself
  	@other_server_infos = ServerInfo.where(["id != ?", @server_info.id])
  end
end

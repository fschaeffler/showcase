class WelcomeController < ApplicationController
  def index
  	@server_info = ServerInfo.find_myself
  	@other_server_infos = ServerInfo.where(["id != ?", @server_info.id])
  end

	def send_email
		ServerInfoMailer.send_email(server_info: ServerInfo.find_myself).deliver_later
		redirect_to root_url, notice: "Email sent. Please check your Inbox."
	end
end
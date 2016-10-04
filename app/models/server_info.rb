require 'socket'
require 'open-uri'
require 'resolv'

class ServerInfo < ActiveRecord::Base
	validates_uniqueness_of :remote_ip

	def self.find_myself
		ip_remote = open('http://whatismyip.akamai.com').read

		if ip_remote
			server_info = ServerInfo.find_or_create_by(remote_ip: ip_remote);

			begin
				server_info.remote_dns = Resolv.getname(ip_remote)
			rescue
				server_info.remote_dns = nil
			end

			ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
    		server_info.local_ip = ip.ip_address if ip
    		server_info.local_dns = Socket.gethostname

    		server_info.save

    		server_info
		else
			null
		end
	end
end

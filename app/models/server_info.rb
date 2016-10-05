require 'socket'
require 'open-uri'
require 'resolv'
require 'os'

class ServerInfo < ActiveRecord::Base
	validates_uniqueness_of :remote_ip

	def self.find_myself
		ip_remote = open('http://whatismyip.akamai.com').read
		ip_remote = '1.1.1.1'

		if ip_remote
			server_info = ServerInfo.find_or_create_by(remote_ip: ip_remote)

			begin
				server_info.remote_dns = Resolv.getname(ip_remote)
			rescue
				server_info.remote_dns = nil
			end

			ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
    		server_info.local_ip = ip.ip_address if ip
    		server_info.local_dns = Socket.gethostname

    		if OS.linux?
    			server_info.os_type = 'linux'
    		elsif OS.windows?
    			server_info.os_type = 'windows'
    		elsif OS.bsd?
    			server_info.os_type = 'bsd'
    		end	

    		server_info.save

    		server_info
		else
			null
		end
	end
end

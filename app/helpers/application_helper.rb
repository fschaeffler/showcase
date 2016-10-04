module ApplicationHelper
	def get_color_class server_info
		color_id = (server_info && server_info.id ? (server_info.id % 3) : 0);
		color_class = 'backgroundColor' + color_id.to_s;
	end

	def get_os_type_image server_info
		server_info ? server_info.os_type + '.png' : 'unkown.png'
	end
end

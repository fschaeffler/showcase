class ServerInfoMailer < ApplicationMailer
  def send_email(options={})
    @server_info = options[:server_info]
    @email = options[:email]

    mail(:to=>"flo@schf.de", :subject=>"Amazon SES Email")
  end
end

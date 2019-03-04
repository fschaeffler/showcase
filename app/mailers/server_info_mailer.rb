# frozen_string_literal: true

class ServerInfoMailer < ApplicationMailer
  def send_email(options = {})
    @server_info = options[:server_info]
    @email = options[:email]

    mail(to: 'flo@aws-blog.io', subject: 'Amazon SES Email')
  end
end

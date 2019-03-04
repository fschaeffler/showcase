# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'flo@aws-blog.io'
  layout 'mailer'
end

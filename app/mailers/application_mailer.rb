class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_ADDRESS']
end

#!/usr/bin/ruby

require "sinatra"
require "mailgun"

mailgun_api_key = ENV['MAILGUN_API_KEY']
mailgun_username = ENV['MAILGUN_USERNAME']
mailgun_password = ENV['MAILGUN_PASSWORD']
sending_domain = ENV['MAILGUN_DOMAIN']
email_to = ENV['MAILGUN_TO']
email_from = ENV['MAILGUN_FROM'] || 'do-not-reply'
email_subject = ENV['MAILGUN_SUBJECT'] || 'subject line'
email_body = ENV['MAILGUN_BODY'] || 'email body'

# if (defined?(mailgun_api_key)).nil?
#   print "No Mailgun API key found in MAILGUN_API_KEY env var. Not sending any emails.\n"
if (defined?(mailgun_username)).nil? or (defined?(mailgun_password)).nil?
  print "Either MAILGUN_USERNAME or MAILBOX_PASSWORD env var is not defined. Not sending any emails.\n"
elsif (defined?(sending_domain)).nil?
  print "No MAILGUN_DOMAIN env var. Not sending any emails."
elsif (defined?(email_to)).nil?
  print "No MAILGUN_TO env var. Not sending any emails.\n"
else
  print "MAILGUN_API_KEY is defined. Sending email.\n"

  address = "smtp.mailgun.org"
  # port = 587

  # Send simple plaintext email message
  mailgun = Mailgun::Client.new MAILGUN_API_KEY
  message = Mailgun::MessageBuilder.new

  # Define the from address.
  message.set_from_address("me@example.com", {"first"=>"Me", "last" => "Example"})

  # Define a to recipient.
  message.add_recipient(:to, email_to, {"first" => "John", "last" => "Doe"})

  # Define the subject.
  message.set_subject(email_subject)

  # Define the body of the message.
  message.set_text_body(email_body)

  # # Define the HTML text of the message
  # message.set_html_body("<html><body><p>This is the text body of the message</p></body></html>")

  # Other Optional Parameters.
  # message.add_campaign_id("My-Awesome-Campaign")
  # message.header("Customer-Id", "12345")
  message.add_attachment(ENV['LOG_FILE'])
  # message.set_delivery_time("tomorrow 8:00AM PST")
  # message.set_click_tracking(true)

  # Send your message through the client
  mg_client.send_message(address, message)
end

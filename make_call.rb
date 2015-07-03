require 'twilio-ruby'

client = Twilio::REST::Client.new(ENV['TWILIO_HEALTH_MISC_SID'], ENV['TWILIO_HEALTH_MISC_AUTH'])
twilio_number = '+15593992674'

client.account.calls.create(
  from: twilio_number,
  to: '+18553555757',
  url: 'https://268d06ca.ngrok.com/',
  method: 'GET'
)


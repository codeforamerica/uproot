require 'twilio-ruby'
require File.expand_path('../phone_number', __FILE__)

class CallToIvrScreen
  CLIENT = Twilio::REST::Client.new(ENV['TWILIO_HEALTH_MISC_SID'], ENV['TWILIO_HEALTH_MISC_AUTH'])
  TWILIO_NUMBER = '+15593992674'

  def initialize(args)
    @digit_sequence = args[:digit_sequence]
    @ivr_phone_number = PhoneNumber.new(args[:ivr_phone_number])
  end

  def initiate!
    CLIENT.account.calls.create(
      from: TWILIO_NUMBER,
      to: @ivr_phone_number.to_twilio_format,
      url: "https://268d06ca.ngrok.com/ivr/#{@ivr_phone_number.to_url_format}/digits/#{@digit_sequence}/twilio-instructions",
      method: 'GET'
    )
  end
end

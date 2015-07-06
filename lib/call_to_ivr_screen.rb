require 'twilio-ruby'
require File.expand_path('../phone_number', __FILE__)

class CallToIvrScreen
  CLIENT = Twilio::REST::Client.new(ENV['UPROOT_TWILIO_SID'], ENV['UPROOT_TWILIO_AUTH'])
  TWILIO_NUMBER = ENV['UPROOT_TWILIO_NUMBER']

  def initialize(args)
    @digit_sequence = args[:digit_sequence]
    @ivr_phone_number = PhoneNumber.new(args[:ivr_phone_number])
  end

  def initiate!
    CLIENT.account.calls.create(
      from: TWILIO_NUMBER,
      to: @ivr_phone_number.to_twilio_format,
      url: "#{ENV['UPROOT_BASE_URL']}/ivr/#{@ivr_phone_number.to_url_format}/digits/#{@digit_sequence}/twilio-instructions",
      method: 'GET'
    )
  end
end

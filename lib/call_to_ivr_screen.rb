require 'twilio-ruby'

class CallToIvrScreen
  CLIENT = Twilio::REST::Client.new(ENV['TWILIO_HEALTH_MISC_SID'], ENV['TWILIO_HEALTH_MISC_AUTH'])
  TWILIO_NUMBER = '+15593992674'

  def initialize(digit_sequence)
    @digit_sequence = digit_sequence
  end

  def initiate!
    CLIENT.account.calls.create(
      from: TWILIO_NUMBER,
      to: '+18553555757',
      url: "https://268d06ca.ngrok.com/digits/#{@digit_sequence}",
      method: 'GET'
    )
  end
end

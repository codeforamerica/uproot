require 'sinatra'
require 'twilio-ruby'

get '/' do
  Twilio::TwiML::Response.new do |r|
    # First screen
    r.Play digits: 'wwwwwwwwwwwwwwwwwwwwwwwwww1'
    # Second screen
    #r.Play digits: 'wwwwwwwwwwwwwwwwwwwwwwwwww1wwwwwwww1'
    # Third screen
    #r.Play digits: 'wwwwwwwwwwwwwwwwwwwwwwwwww1wwwwwwww1wwwwwww1'
    r.Record(transcribe: true, maxLength: 45)
  end.text
end


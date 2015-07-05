require 'sinatra'
require 'twilio-ruby'
require 'pry'
require File.expand_path("../lib/ivr_screen", __FILE__)
require File.expand_path("../lib/call_to_ivr_screen", __FILE__)

class Uproot < Sinatra::Base
  get '/digits/:digit_sequence' do
    digit_sequence = params[:digit_sequence]
    Twilio::TwiML::Response.new do |r|
      r.Play digits: digit_sequence
      r.Record(
        transcribe: true,
        transcribeCallback: "https://268d06ca.ngrok.com/handle-transcription/#{digit_sequence}",
        maxLength: 60
      )
    end.text
  end

  post '/digits/:digit_sequence' do
    puts params
    # This gets hit by default by Twilio recording, so just want to return a response
    ""
  end

  post '/handle-transcription/:digit_sequence' do
    current_screen = IvrScreen.new(
      transcription_text: params[:TranscriptionText],
      digit_sequence: params[:digit_sequence]
    )

    puts params[:TranscriptionText]
    puts current_screen.next_screen_options

    current_screen.next_screen_options.each do |button_option|
      sequence_for_next_screen = current_screen.digit_sequence + "wwwwww#{button_option}"
      puts "Initiating call for: #{sequence_for_next_screen}"
      CallToIvrScreen.new(sequence_for_next_screen).initiate!
    end
    ""
  end
end

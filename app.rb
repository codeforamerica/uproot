require 'sinatra'
require 'twilio-ruby'
require 'sinatra/activerecord'
require 'pry'
require File.expand_path("../lib/ivr_screen", __FILE__)
require File.expand_path("../lib/call_to_ivr_screen", __FILE__)

class Uproot < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, File.expand_path('../config/database.yml', __FILE__)

  get '/ivr/:ivr_phone_number' do
    @all_screens = IvrScreen.where('ivr_phone_number = ?', params[:ivr_phone_number])
    erb :ivr
  end

  get '/ivr/:ivr_phone_number/digits/:digit_sequence/twilio-instructions' do
    digit_sequence = params[:digit_sequence]
    ivr_phone_number = params[:ivr_phone_number]
    Twilio::TwiML::Response.new do |r|
      r.Play digits: digit_sequence
      r.Record(
        action: "https://268d06ca.ngrok.com/ivr/#{ivr_phone_number}/digits/#{digit_sequence}/audio-recording",
        transcribe: true,
        transcribeCallback: "https://268d06ca.ngrok.com/ivr/#{ivr_phone_number}/digits/#{digit_sequence}/transcription",
        maxLength: 60
      )
    end.text
  end

  post '/ivr/:ivr_phone_number/digits/:digit_sequence/audio-recording' do
    current_screen_results = IvrScreen.where(
      "ivr_phone_number = ? and digit_sequence = ?",
      params[:ivr_phone_number],
      params[:digit_sequence]
    )
    if current_screen_results.empty?
      current_screen = IvrScreen.create(
        ivr_phone_number: params[:ivr_phone_number],
        digit_sequence: params[:digit_sequence],
        recording_url: params[:RecordingUrl]
      )
    else
      current_screen = current_screen_results.first
      current_screen.transcription_text = params[:TranscriptionText]
      current_screen.save
    end
    puts params
    ""
  end

  post '/ivr/:ivr_phone_number/digits/:digit_sequence/transcription' do
    puts params
    current_screen_results = IvrScreen.where(
      "ivr_phone_number = ? and digit_sequence = ?",
      params[:ivr_phone_number],
      params[:digit_sequence]
    )
    if current_screen_results.empty?
      current_screen = IvrScreen.create(
        ivr_phone_number: params[:ivr_phone_number],
        digit_sequence: params[:digit_sequence],
        transcription_text: params[:TranscriptionText],
      )
    else
      current_screen = current_screen_results.first
      current_screen.transcription_text = params[:TranscriptionText]
      current_screen.save
    end

    puts params[:TranscriptionText]
    puts current_screen.next_screen_options

    current_screen.next_screen_options.each do |button_option|
      sequence_for_next_screen = current_screen.digit_sequence + "wwwwww#{button_option}"
      puts "Initiating call for: #{sequence_for_next_screen}"
      CallToIvrScreen.new(
        ivr_phone_number: params[:ivr_phone_number],
        digit_sequence: sequence_for_next_screen
      ).initiate!
    end
    ""
  end
end

require 'spec_helper'

describe Uproot, type: :feature do
  let(:fake_call) { double("CallToIvrScreen", :initiate! => "") }
  let(:transcription) { "Our office is closed. Our normal business hours are between 8:00 AM and 5:00 PM Monday through Friday to apply for food assistance and or medical health benefits online. Please visit our website at www.mybenefitscalvin.org. Our website also offers case information for current customers for office locations press 1 to hear automated information about your case press 2 For information on other ways to apply for benefits. Press 3 For frequently asked questions and program information press 4" }

  before do
    allow(CallToIvrScreen).to receive(:new).and_return(fake_call)
  end

  it 'works' do
    post '/ivr/12223334444/digits/www1/transcription', {
      "TranscriptionText" => transcription
    }
    expect(fake_call).to have_received(:initiate!).exactly(4).times
  end

  context 'given a digit sequence of depth 4' do
    let(:digit_sequence) { 'ww1ww2ww3ww4' }

    it 'does not initiate more calls' do
      post "/ivr/12223334444/digits/#{digit_sequence}/transcription", {
        "TranscriptionText" => transcription
      }
      expect(fake_call).to_not have_received(:initiate!)
    end
  end
end

require 'app_spec_helper'

describe Uproot, type: :feature do
  let(:fake_call) { double("CallToIvrScreen", :initiate! => "") }

  before do
    allow(CallToIvrScreen).to receive(:new).and_return(fake_call)
  end

  it 'works' do
    transcription = "Our office is closed. Our normal business hours are between 8:00 AM and 5:00 PM Monday through Friday to apply for food assistance and or medical health benefits online. Please visit our website at www.mybenefitscalvin.org. Our website also offers case information for current customers for office locations press 1 to hear automated information about your case press 2 For information on other ways to apply for benefits. Press 3 For frequently asked questions and program information press 4"
    post '/handle-transcription/wwwwwwwwwwwwww1', {
      "TranscriptionText" => transcription
    }
    expect(fake_call).to have_received(:initiate!).exactly(4).times
  end
end

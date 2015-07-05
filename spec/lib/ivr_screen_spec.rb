require 'spec_helper'

describe IvrScreen do
  context 'given basic args' do
    let(:ivr_screen) {
      transcription_text = "Your call maybe monitored or recorded to improve customer service. For information on how to apply for benefits or information on your pending application. Press 1 For information on your existing food assistance please press 2 For information on your existing health coverage please press 3 For information on call flash copy press 4 For frequently asked questions press 5 To repeat this information press 8 To return to the previous menu press 9"
      IvrScreen.new(
        transcription_text: transcription_text,
        digit_sequence: "wwww1"
      )
    }

    it 'gives the digit sequence' do
      expect(ivr_screen.digit_sequence).to eq('wwww1')
    end

    it 'processes the transcription into options for the next screen' do
      expect(ivr_screen.next_screen_options).to eq([1, 2, 3, 4, 5])
    end
  end
end

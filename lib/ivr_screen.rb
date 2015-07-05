class IvrScreen < ActiveRecord::Base
  def next_screen_options
    @next_screen_options ||= extract_screen_options_from_transcription(transcription_text)
  end

  def depth_level
    digit_button_pushes = digit_sequence.scan(/(\d+)/)
    digit_button_pushes.count
  end

  private
  def extract_screen_options_from_transcription(text)
    if text == nil
      []
    else
      digits_inside_arrays = text.scan(/[pP]ress (\d)/)
      digits_inside_arrays.map do |digit_inside_array|
        digit_inside_array[0].to_i
      end.select do |digit|
        self.class.button_blacklist.include?(digit) == false
      end
    end
  end

  def self.button_blacklist
    # Currently for SF HSA line
    [0, 8, 9]
  end
end

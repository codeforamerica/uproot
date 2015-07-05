class IvrScreen
  attr_reader :digit_sequence

  def initialize(args)
    @transcription_text = args[:transcription_text]
    @digit_sequence = args[:digit_sequence]
  end

  def next_screen_options
    @next_screen_options ||= extract_screen_options_from_transcription(@transcription_text)
  end

  private
  def extract_screen_options_from_transcription(text)
    digits_inside_arrays = text.scan(/[pP]ress (\d)/)
    digits_inside_arrays.map do |digit_inside_array|
      digit_inside_array[0].to_i
    end.select do |digit|
      self.class.button_blacklist.include?(digit) == false
    end
  end

  def self.button_blacklist
    # Currently for SF HSA line
    [0, 8, 9]
  end
end
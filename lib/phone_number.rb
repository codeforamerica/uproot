class PhoneNumber
  def initialize(string)
    @phone_number_string = string
  end

  def to_twilio_format
    if @phone_number_string[0] != '+'
      '+' + @phone_number_string
    else
      @phone_number_string
    end
  end

  def to_url_format
    if @phone_number_string[0] == '+'
      @phone_number_string[1..-1]
    else
      @phone_number_string
    end
  end
end

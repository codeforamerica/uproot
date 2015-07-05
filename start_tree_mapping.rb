require File.expand_path("../lib/call_to_ivr_screen", __FILE__)

CallToIvrScreen.new(
  digit_sequence: "wwwwwwwwwwwwwwwwwwwwwwwwww1",
  ivr_phone_number: '+18553555757'
).initiate!

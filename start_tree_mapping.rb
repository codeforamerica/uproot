require File.expand_path("../lib/call_to_ivr_screen", __FILE__)

=begin
# SF HSA
CallToIvrScreen.new(
  digit_sequence: "wwwwwwwwwwwwwwwwwwwwwwwwww1",
  ivr_phone_number: '+18553555757'
).initiate!

# Alameda County SSA
CallToIvrScreen.new(
  digit_sequence: "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww1",
  ivr_phone_number: '+18889994772'
).initiate!
=end

class CreateIvrScreens < ActiveRecord::Migration
  def change
    create_table :ivr_screens do |t|
      t.string :ivr_phone_number
      t.string :digit_sequence
      t.string :transcription_text
      t.string :recording_url
    end
  end
end

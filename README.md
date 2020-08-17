# Uproot

A robot that maps out phone trees using Twilio calling and transcriptions

Initial project idea: https://github.com/codeforamerica/project-ideas/issues/22 (HT @lippytak)

## Status

Very early development / feasibility assessment

## Usage

Currently the repo contains exploratory work to understand the feasibility and think through technical approaches.

The basic approach looks like this:

1. Start the whole thing by running code to initiate a call to a # with a button sequence (eg, wait 20 seconds and press 1 for English)

2. It records that call, transcribes it, and sends the transcription back to the app

3. The app looks for "press N" in the transcription text, and for each of those initiates a call similar to (1) but with a bit more of a button sequence added on (eg, wait 20s, press 1, wait 5s, press 2)

4. Break at 4 levels deep

This is all exploratory at this point, and so poorly documented for now.


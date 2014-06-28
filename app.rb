# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
require 'volumerb'
require 'json'

get '/' do
  haml :index
end

# Available routes:
#   up   - Increases volume by 3%
#   down - Decreases volume by 3%
#   mute    - Toggles mute/unmute
# == Returns:
# see 'get_vol'
get '/:route' do
  fork do
    Volumerb.send(params[:route].to_sym)
  end
  Volumerb.vol.to_json
end

# Returns a JSON value with the volume
# == Returns:
# A JSON value with two keys: "number" and "state". The "number" value
# is the current volume value and the "state" represents if the system
# volume is muted or not. Example: `{"number":"50","state":"off"}
def volume
  if RUBY_PLATFORM =~ /linux/
    Volumerb::LinuxVolume.vol
  elsif RUBY_PLATFORM =~ /darwin|macos/
    Volumerb::MacVolume.vol
  end
end

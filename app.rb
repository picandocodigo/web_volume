require 'sinatra'
require 'haml'
require './lib/volume'

get '/' do
  haml :index
end

# Available routes:
#   volup   - Increases volume by 3%
#   voldown - Decreases volume by 3%
#   mute    - Toggles mute/unmute
# == Returns:
# see 'get_vol'
get '/:route' do
  Volume.send(params[:route].to_sym)
  volume
end

# Returns a JSON value with the volume
# == Returns:
# A JSON value with two keys: "number" and "state". The "number" value
# is the current volume value and the "state" represents if the system
# volume is muted or not. Example: `{"number":"50","state":"off"}
def volume
  Volume.vol
end

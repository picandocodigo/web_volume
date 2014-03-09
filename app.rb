require 'sinatra'
require 'haml'
require 'json'

get '/' do
  haml :index
end

# Increases volume by 3%
# == Returns:
# A JSON value with two keys: "number" and "state". The "number" value
# is the current volume value and the "state" represents if the system
# volume is muted or not. Example: `{"number":"97","state":"on"}`
get '/volup' do
  v = "amixer -q sset Master 3%+"
  `#{v}`
  get_vol
end

# Decreases volume by 3%
# == Returns:
# A JSON value with two keys: "number" and "state". The "number" value
# is the current volume value and the "state" represents if the system
# volume is muted or not. Example: `{"number":"94","state":"on"}
get '/voldown' do
  `amixer -q sset Master 3%-`
  get_vol
end

# Toggles mute/unmute
# == Returns:
# A JSON value with two keys: "number" and "state". The "number" value
# is the current volume value and the "state" represents if the system
# volume is muted or not. Example: `{"number":"50","state":"off"}
get '/mute' do
  `amixer sset Master toggle`
  get_vol
end

# Returns a JSON value with the volume
# == Returns:
# A JSON value with two keys: "number" and "state". The "number" value
# is the current volume value and the "state" represents if the system
# volume is muted or not. Example: `{"number":"50","state":"off"}
get '/vol' do
  get_vol
end

def get_vol
  vol = `amixer get Master | grep "\[[0-9]*%\]\ \[o[n|f]"`
  number = vol.match(/([0-9]+)%/)[1]
  state = vol.match(/\[([a-z]+)\]/)[1]
  {
    number: number.to_s,
    state: state.to_s
  }.to_json
end

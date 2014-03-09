require 'sinatra'
require 'haml'
require 'json'

get '/' do
  
  haml :index
end

get '/volup' do
  v = "amixer -q sset Master 3%+"
  `#{v}`
  get_vol
end

get '/voldown' do
  `amixer -q sset Master 3%-`
  get_vol
end

get '/mute' do
  `amixer sset Master toggle`
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

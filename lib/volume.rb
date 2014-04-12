# -*- coding: utf-8 -*-
require 'json'

module Volume
  module LinuxVolume
    def self.volup
      `amixer -q sset Master 3%+`
    end

    def self.voldown
      `amixer -q sset Master 3%-`
    end

    def self.mute
      `amixer sset Master toggle`
    end

    def self.vol
      vol = `amixer get Master | grep "\[[0-9]*%\]\ \[o[n|f]"`
      number = vol.match(/([0-9]+)%/)[1]
      state = vol.match(/\[([a-z]+)\]/)[1]
      { number: number.to_s, state: state.to_s }.to_json
    end
  end

  module MacVolume
    def self.volup
      osa 'set currentVolume to output volume of (get volume settings)
           set volume output volume (currentVolume + 3)'
    end

    def self.voldown
      osa 'set currentVolume to output volume of (get volume settings)
           set volume output volume (currentVolume - 3)'
    end

    def self.mute
      state = osa 'output muted of (get volume settings)'
      setmute = !eval(state)
      osa "set volume output muted #{setmute}"
    end

    def self.vol
      # Mac OS X output:
      # output volume:100, input volume:missing value, alert
      # volume:98, output muted:false
      vol = osa 'get volume settings'
      number = vol.match(/output\ volume\:([0-9]+)/)[1]
      state = vol.match(/muted:([t|f])/)[1]
      { number: number.to_s, state: state.to_s }.to_json
    end

    private

    def self.osa(script)
      `osascript -e '#{script}'`
    end
  end
end


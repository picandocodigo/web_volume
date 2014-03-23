require 'json'

module Volume
  def self.volup
    if RUBY_PLATFORM =~ /darwin|macos/
      osa 'set currentVolume to output volume of (get volume settings)
           set volume output volume (currentVolume + 3)'

    elsif RUBY_PLATFORM =~ /linux/
      `amixer -q sset Master 3%+`
    end
  end

  def self.voldown
    if RUBY_PLATFORM =~ /darwin|macos/
      osa 'set currentVolume to output volume of (get volume settings)
           set volume output volume (currentVolume - 3)'
    elsif RUBY_PLATFORM =~ /linux/
      `amixer -q sset Master 3%-`
    end
  end

  def self.mute
    if RUBY_PLATFORM =~ /linux/
      `amixer sset Master toggle`
    elsif RUBY_PLATFORM =~ /darwin|macos/
      state = osa 'output muted of (get volume settings)'
      setmute = !eval(state)
      osa "set volume output muted #{setmute}"
    end
  end

  def self.vol
    if RUBY_PLATFORM =~ /linux/
      vol = `amixer get Master | grep "\[[0-9]*%\]\ \[o[n|f]"`
      number = vol.match(/([0-9]+)%/)[1]
      state = vol.match(/\[([a-z]+)\]/)[1]
    elsif RUBY_PLATFORM =~ /darwin|macos/
      # Mac OS X output:
      # output volume:100, input volume:missing value, alert
      # volume:98, output muted:false
      vol = osa 'get volume settings'
      number = vol.match(/output\ volume\:([0-9]+)/)[1]
      state = vol.match(/muted:([t|f])/)[1]
    end
    { number: number.to_s, state: state.to_s }.to_json
  end

  private

  def self.osa(script)
    `osascript -e '#{script}'`
  end
end

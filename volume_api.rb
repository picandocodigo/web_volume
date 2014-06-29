# -*- coding: utf-8 -*-
require 'cuba'
require 'cuba/render'
require 'haml'
require 'volumerb'
require 'json'

Cuba.plugin Cuba::Render
Cuba.use(Rack::Static, urls: %w[/css /js], root: 'public')

Cuba.define do
  on root do
    res.write render('views/index.haml')
  end

  on ':route' do |r|
    fork do
      Volumerb.send(r.to_sym)
    end
    res.write Volumerb.vol.to_json
  end
end

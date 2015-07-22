require 'bundler'
Bundler.require

opal = Opal::Server.new {|s|
  s.append_path '.'
  s.append_path '../../assets'
  s.source_map = true
  s.debug = true
  s.main = 'main'
}


sprockets   = opal.sprockets
maps_prefix = '/__OPAL_SOURCE_MAPS__'
maps_app    = Opal::SourceMapServer.new(sprockets, maps_prefix)

# Monkeypatch sourcemap header support into sprockets
::Opal::Sprockets::SourceMapHeaderPatch.inject!(maps_prefix)

map maps_prefix do
  run maps_app
end

map '/assets' do
  run sprockets
end

get '/' do
  send_file 'index.html'
end

run Sinatra::Application

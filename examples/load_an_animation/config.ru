require 'bundler'
Bundler.require

opal = Opal::Server.new {|s|
  s.append_path '.'
  s.append_path '../assets'
  s.main = 'load_an_animation'
}

map '/assets' do
  run opal.sprockets
end

get '/' do
  <<-HTML
    <!doctype html>
    <html>
      <head>
        <title>Load an animation</title>
        </style>
        <script src="/dist/phaser.js"></script>
        <script src="/assets/load_an_animation.js"></script>
      </head>
      <body>
        <script>
          window.onload = function() {
            Opal.LoadAnAnimation.$new()
          }
        </script>
      </body>
    </html>
  HTML
end

run Sinatra::Application

require 'bundler'
Bundler.require

opal = Opal::Server.new {|s|
  s.append_path '.'
  s.append_path '../assets'
  s.main = 'image_follow_input'
}

map '/assets' do
  run opal.sprockets
end

get '/' do
  <<-HTML
    <!doctype html>
    <html>
      <head>
        <title>Image follow input</title>
        </style>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/phaser/2.2.1/phaser.min.js"></script>
        <script src="/assets/image_follow_input.js"></script>
      </head>
      <body>
        <script>
          window.onload = function() {
            Opal.ImageFollowInput.$new()
          }
        </script>
      </body>
    </html>
  HTML
end

run Sinatra::Application

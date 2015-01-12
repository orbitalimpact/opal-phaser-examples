require 'bundler'
Bundler.require

opal = Opal::Server.new {|s|
  s.append_path '.'
  s.append_path '../assets'
  s.main = 'move_an_image'
}

map '/assets' do
  run opal.sprockets
end

get '/' do
  <<-HTML
    <!doctype html>
    <html>
      <head>
        <title>Move an Image</title>
        <style>
        body {
        	background-color: gray;
        }
        </style>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/phaser/2.2.1/phaser.min.js"></script>
        <script src="/assets/move_an_image.js"></script>
      </head>
      <body>
        <script>
          window.onload = function() {
            Opal.MoveAnImage.$new()
          }
        </script>
      </body>
    </html>
  HTML
end

run Sinatra::Application

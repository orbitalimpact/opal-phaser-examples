require 'bundler'
Bundler.require

opal = Opal::Server.new {|s|
  s.append_path '.'
  s.append_path '../assets'
  s.main = 'click_on_an_image'
}

map '/assets' do
  run opal.sprockets
end

get '/' do
  <<-HTML
    <!doctype html>
    <html>
      <head>
        <title>Click on an Image</title>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/phaser/2.2.1/phaser.min.js"></script>
        <script src="/assets/click_on_an_image.js"></script>
      </head>
      <style>
      body {
      	background-color: gray;
      }
      </style>
      <body>
        <script>
          window.onload = function() {
            Opal.ClickOnAnImage.$new()
          }
        </script>
      </body>
    </html>
  HTML
end

run Sinatra::Application

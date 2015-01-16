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
          <script src="http://cdnjs.cloudflare.com/ajax/libs/phaser/2.2.1/phaser.min.js"></script>
          <script src="/assets/move_an_image.js"></script>
      </head>
      <style>
      body {
      	background-color: #993333;
      }
      #logo {
          height: 120px;
          width: 120px;
          float: right;
      }
      #title {
          font-family: 'HelveticaBd', Helvetica, Arial;
          font-size: 55px;
          color: #ffffff;
          text-shadow: 0 0 15px blue;
          text-transform: capitalize;
      }
      #example {
          width: 800px;
          height: 600px;
          border-style: solid;
          border-color: gray;
          border-radius: 5px;
      }
      </style>
      <body>
        <script>
          window.onload = function() {
            Opal.MoveAnImage.$new()
          }
        </script>
        <a href="https://github.com/orbitalimpact/opal-phaser-examples">
            <img id="logo" src="https://raw.githubusercontent.com/orbitalimpact/opal-phaser/master/common/images/logo.png"/>
        </a>
        <center>
            <span id="title">move an image</span>
            <div id="example"></div>
        </center>
      </body>
    </html>
  HTML
end

run Sinatra::Application

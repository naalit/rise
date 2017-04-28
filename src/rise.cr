require "./rise/*"
require "http/client"

module Rise

engine = Engine.new
if !ARGV[0]?
  puts engine.run(%{
  <html>
      <body>
          <h1>Title</h1>
          <div id="main" class="test">
              <p>Hello <em>world</em>!</p>
            </div>
        </body>
    </html>
  })
else
  response = HTTP::Client.get ARGV[0]
  puts response.body
  puts engine.run(response.body)
end

end # Those cascading end's look cool

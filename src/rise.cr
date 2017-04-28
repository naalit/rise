require "./rise/*"

module Rise

engine = Engine.new
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

end # Those cascading end's look cool

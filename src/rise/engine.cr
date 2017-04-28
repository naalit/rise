module Rise

class Engine
  def run(source : String)
    tree = HTML.parse source
    puts "Parsed, converting to String..."
    return tree.to_s

    # TODO - start implementation of something that does something with the DOM tree instead of just pretty-printing it.
  end
end

end

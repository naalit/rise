# DOM module
module Rise::DOM

  class Node
    def initialize(@children : Array(Node))

    end

    def children=(arg)
      @children = arg
    end

    def to_s
      result = ""
      i = 0
      while i != @children.size
        result += @children[i].to_s
        i += 1
      end
      result
    end
  end

  class ElementNode < Node
    def initialize(@tag_name : String, @attributes : Hash(String, String))
      @children = Array(Node).new
    end
    def initialize(@tag_name : String, @attributes : Hash(String, String), @children : Array(Node))

    end

    def to_s
      result = ""
      result += "Element " + @tag_name + " with attributes: " + @attributes.to_s + "\n"
      result += super.to_s
    end
  end

  class TextNode < Node
    def initialize(@data : String)
      @children = Array(Node).new
    end

    def to_s
      result = ""
      result += "Text: " + @data + "\n"
      result += super.to_s
    end
  end

end

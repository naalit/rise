# HTML parser module
module Rise::HTML

extend self

class Parser
  @pos = 0
  def initialize
    @input = ""
  end
  def initialize(@input : String)

  end

  def next_char
    c = @input[@pos]?
    if !c
      return '|'
    else
      return c
    end
  end

  def starts_with(s : String)
    @input[@pos, s.size] == s
  end

  # Haven't checked API for len, push, starts_with - if it breaks, check
  def eof
    @pos >= @input.size
  end

  def consume
    joe = next_char
    @pos += 1
    joe
  end

  def consume_while
    result = ""
    while yield && !eof
      result += consume#.to_s
    end
    result
  end

  def consume_whitespace
    consume_while { next_char.whitespace? }
  end

  def parse_tag_name
    consume_while { next_char.alphanumeric? }
  end

  def parse_node
    case next_char
    when '<'
      parse_element
    else
      parse_text
    end
  end

  def parse_text
    DOM::TextNode.new consume_while {
      next_char != '<'
    }
  end

  def parse_element
    if (consume == '<')
    else
      puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: I couldn't find an opening tag, even though I already looked for one and found it - okay, so the problem is probably on my end. Submit a bug report, then, if those exist yet. We'll call this ERROR No. 8192."
    end
    tag_name = parse_tag_name
    attrs = parse_attributes
    if (consume == '>')
    else
      puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: I couldn't find a closing '>' on your opening tag."
    end

    children = parse_nodes

    if (consume == '<')
    else
      puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: I couldn't find a opening '<' on your closing tag."
    end
    if (consume == '/')
    else
      puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: I couldn't find a '/' on your closing tag."
    end
    if (parse_tag_name == tag_name)
    else
      puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: unbalanced tags."
    end
    if (consume == '>')
    else
      puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: I couldn't find a closing '>' on your closing tag."
    end

    DOM::ElementNode.new(tag_name, attrs, children)
  end

  def parse_attributes
    attributes = Hash(String, String).new
    while true
      consume_whitespace
      if next_char == '>'
        break
      end

      # parse_attr in the tutorials
      name = parse_tag_name
      if (consume == '=')
      else
        puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: I couldn't find a '=' on your attribute."
      end
      value = parse_attr_value

      # Back to parse_attributes
      attributes[name] = value
    end
    return attributes
  end

  def parse_nodes
    nodes = Array(DOM::Node).new
    loop {
      consume_whitespace
      if eof || starts_with "</"
        break
      end
      nodes.push parse_node
    }
    nodes
  end

  def parse_attr_value
    open_quote = consume
    if (open_quote == '"')
    else
      puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: I couldn't find an opening '\"' on your attribute."
    end
    value = consume_while do
      next_char != open_quote
    end
    if (consume == open_quote)
    else
      puts "YOUR HTML IS BROKEN! FIX IT NOW! Either that, or I have a BAD bug in this here parse code. Reason: I couldn't find a closing '\"' on your attribute."
    end
    value
  end
end

def parse(source : String)
  nodes = Parser.new(source).parse_nodes

  # Root element handling
  if nodes.size == 1
    nodes[0]
  else
    DOM::ElementNode.new("html", Hash(String, String).new, nodes)
  end
end

end

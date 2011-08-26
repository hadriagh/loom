class Loom
  class Tag
    def initialize(node)
      @node = node
    end
   
    
    def weave
      return @node.text if @node.text?
      
      html = ''
      prefix = ''
      suffix = "\n"
      
      @node.children.each do |child|
        tag = Tag.new(child)
        html += tag.weave
      end
      
      case @node.name
      when "h1".."h6"
        prefix = @node.name + '. '
      when "b", "strong"
        prefix = '*'
        suffix = '*'
      when "em"
        prefix = '_'
        suffix = '_' 
      when "a"
        prefix = '"'
        suffix = '":' + @node.attr('href')
      when "p"
        prefix = "p. "
      when "ol", "ul"
        suffix = ''
      when "li"
        if(@node.parent.name == 'ol')
          prefix = '# '
        else
          prefix = '* '
        end
      when "img"
        prefix = '!' + @node.attr('src')
        suffix = '!'
      else
        @node.inner_html=(html)
        return @node.to_s
      end
      
      class_text = get_attribute_string
            
      return prefix + class_text + html + suffix
    end
    
    
    def get_attribute_string
      if(@node.attr('class'))
        class_text = '(' + @node.attr('class') + ')'
      else
        class_text = ''
      end
      
      return class_text
    end
  end
 end
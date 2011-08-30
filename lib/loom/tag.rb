class Loom
  class Tag
    def initialize(node)
      @node = node
    end
   
    
    def weave
      return @node.text.lstrip if @node.text?
      
      html = ''
      prefix = ''
      suffix = "\n\n"
      
      @node.children.each do |child|        
        tag = Tag.new(child)
        html += tag.weave
      end
      
      attributes = get_attributes
      
      case @node.name
      when "h1".."h6"
        prefix = @node.name + '. '
      when "b", "strong"
        prefix = '*'
        suffix = '* '
      when "em"
        prefix = '_'
        suffix = '_ ' 
      when "sup"
        prefix = '^'
        suffix = '^ '
      when "sub"
        prefix = "~"
        suffix = "~ "
      when "a"
        prefix = '"'
        suffix = '":' + @node.attr('href')
      when "p"
        prefix = 'p' + attributes + '. '
      when "ol", "ul"
        suffix = "\n"
      when "li"
        if(@node.parent.name == 'ol')
          prefix = '# '
        else
          prefix = '* '
        end
        
        suffix = "\n"
      when "img"
        prefix = '!' + @node.attr('src')
        suffix = "!\n\n"
      when "br"
        suffix = "\n"
      else
        @node.inner_html=("\n" + html)
        return @node.to_s + suffix
      end
            
      return prefix + html + suffix
    end
    
    
    def get_attributes
      id = @node.attr('id')
      classes = @node.attr('class')
      
      if(classes || id)
        if(id)
          attributes = '(' + classes.to_s + '#' + id.to_s + ')'
        else
          attributes = '(' + classes.to_s + ')'
        end
      else
        attributes = ''
      end
    end
  end
end
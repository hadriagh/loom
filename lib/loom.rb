require 'nokogiri'
require 'open-uri'
require 'pp'

class Loom
  def self.weave(html)
    
    html_doc = Nokogiri::HTML(html)
    
    html_doc.css('body').each do |node|
      html = replace_tag(node)
    end
    
    puts html
  end
  
  def self.replace_tag(node)
    if(node.text?)
      return node.text
    end    
    
    html = ''
    prefix = ''
    suffix = "\n"
    
    node.children.each do |child|
      html += replace_tag(child)
    end
    
    case node.name
    when "h1".."h6"
      prefix = node.name + '. '
    when "b", "strong"
      prefix = '*'
      suffix = '*'
    when "em"
      prefix = '_'
      suffix = '_' 
    when "a"
      prefix = '"'
      suffix = '":' + node.attr('href')
    when "li"
      if(node.parent.name == 'ol')
        prefix = '# '
      else
        prefix = '* '
      end
    end
    
    if(node.attr('class'))
      class_text = '(' + node.attr('class') + ')'
    else
      class_text = ''
    end
          
    return prefix + class_text + html + suffix
  end
end

Loom.weave('<h1 class="bigboy">This is a <b>Loom</b> test</h1><p>Visit <a href="http://www.loom.com">Loom\'s Homepage</a> for more information</p><ul><li>Unordered 1</li><li>Unordered 2</li></ul>')
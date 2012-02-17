require 'nokogiri'
require 'open-uri'
require 'pp'

class Loom
  def self.weave(html)
    textile = ''
    html_doc = Nokogiri::HTML.fragment(html)
    
    html_doc.children.each do |node|
      tag = Tag.new(node)
      textile += tag.process
    end
    
    return textile
  end
end

require 'loom/tag'
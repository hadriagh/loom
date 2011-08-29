require 'nokogiri'
require 'open-uri'
require 'pp'
require 'sequel'

class Loom
  def self.weave(html)
    textile = ''
    html_doc = Nokogiri::HTML.fragment(html)
    
    html_doc.children.each do |node|
      tag = Tag.new(node)
      textile += tag.weave
    end
    
    return textile
  end
end
require 'nokogiri'
require 'open-uri'
require 'pp'
require 'sequel'

class Loom
  def self.weave(html)
    textile = ''
    html_doc = Nokogiri::HTML(html)
    
    html_doc.css('body').children.each do |node|
      tag = Tag.new(node)
      textile += tag.weave
    end
    
    puts textile
  end
end
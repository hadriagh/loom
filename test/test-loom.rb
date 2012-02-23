require 'minitest/autorun'
require 'loom'  
require 'RedCloth'

class TestLoom < MiniTest::Unit::TestCase
  def setup
  end
  
  def test_headings
    html = "<h1>First Heading</h1>\n<h2>Second Heading</h2>"
    textile = Loom.weave(html);
    
    assert_equal html, RedCloth.new(textile).to_html
  end

  def test_table
    html = File.read('tables.html')
    textile = Loom.weave(html);
    
    assert_equal html, RedCloth.new(textile).to_html
  end
end
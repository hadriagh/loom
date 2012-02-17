require 'minitest/autorun'
require 'loom'  

class TestLoom < MiniTest::Unit::TestCase
  def setup
  end

  def test_table
    html = '<table><tr><td>This</td><td>is</td></tr><tr><td>a</td><td>table</td></tr></table>'
    
    assert_equal "|This|is|\n|a|table|\n", Loom.weave(html)
  end
end
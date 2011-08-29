#!/usr/bin/env ruby
$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'mysql'
require 'sequel'
require 'pp'
require 'loom'
require 'redcloth'
require 'iconv'

DB = Sequel.connect(:adapter=>'mysql', :host=>'harpoon', :database=>'harpoon', :user=>'harpoon', :password=>'2ownHarpoon', :encoding => 'utf8')
DB2 = Sequel.connect(:adapter=>'mysql', :host=>'localhost', :database=>'offers_site', :user=>'offers_site', :password=>'2ownOffersSite', :encoding => 'utf8')

sql = "SELECT press_id, content FROM press_releases"

ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')

DB.fetch(sql) do |row|
  html = ic.iconv(row[:content] + ' ')[0..-2]
  
  textile = Loom.weave(html)
  
  File.open('test.html', 'w') {|f| f.write(RedCloth.new(textile).to_html) }
  
  File.open('test.textile', 'w') {|f| f.write(textile) }
  
  update_ds = DB2["UPDATE press_releases SET content = ? WHERE press_id = ?", textile, row[:press_id]]
  update_ds.update
end

#!/usr/bin/env ruby
$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'mysql'
require 'sequel'
require 'pp'
require 'loom'

DB = Sequel.connect(:adapter=>'mysql', :host=>'harpoon', :database=>'harpoon', :user=>'harpoon', :password=>'2ownHarpoon')
#DB = Sequel.connect(:adapter=>'mysql', :host=>'localhost', :database=>'offers_site', :user=>'offers_site', :password=>'2ownOffersSite')

sql = "SELECT press_id, content FROM press_releases WHERE press_id = 1"

DB.fetch(sql) do |row|
  html = row[:content]

  textile = Loom.weave(html)

  pp textile

  #update_ds = DB["UPDATE press_releases SET content = ? WHERE press_id = ?", html, row[:press_id]]
  #update_ds.update
end

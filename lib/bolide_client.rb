require 'rubygems'
require 'patron'
require 'nokogiri'
require 'digest/md5'


module Bolide


  autoload :Account, File.expand_path("../bolide/account.rb", __FILE__)
  autoload :Q, File.expand_path("../bolide/q.rb", __FILE__)
  

end
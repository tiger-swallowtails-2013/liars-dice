puts __FILE__
puts File.dirname(__FILE__)
puts File.expand_path(__FILE__)
puts File.basename(File.expand_path(__FILE__))
puts File.expand_path("..")
f = File.expand_path(".")
puts File.basename(f)
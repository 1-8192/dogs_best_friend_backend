require 'nokogiri'
require 'open-uri'
require 'byebug'

doc = Nokogiri::HTML(open('https://www.nycacc.org/adopt/camellia-60112'))

puts doc.css("#animal-summary")[0].text

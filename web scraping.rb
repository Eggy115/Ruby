require 'nokogiri'
require 'open-uri'

url = 'https://www.example.com'

html = open(url)
doc = Nokogiri::HTML(html)

# Find all links on the page
links = doc.css('a')

# Print out the href attribute for each link
links.each do |link|
  puts link.attribute('href').value
end

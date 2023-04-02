require 'json'

json_string = '{"name": "John", "age": 30, "city": "New York"}'

# Parse JSON string into a hash
data = JSON.parse(json_string)

# Print out the hash
puts data.inspect

# Access individual values in the hash
puts "Name: #{data['name']}"
puts "Age: #{data['age']}"
puts "City: #{data['city']}"

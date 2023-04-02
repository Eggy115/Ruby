# Read file contents
File.open('file.txt', 'r') do |f|
  puts f.read
end

# Write to file
File.open('file.txt', 'w') do |f|
  f.write('This is a test.')
end

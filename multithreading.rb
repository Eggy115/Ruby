# Create a new thread and run a block of code
thread = Thread.new do
  puts "Hello from thread!"
end

# Wait for the thread to finish executing
thread.join

# Create multiple threads to run in parallel
threads = []
10.times do |i|
  threads << Thread.new(i) do |num|
    puts "Thread #{num} started"
    sleep(rand(5))
    puts "Thread #{num} finished"
  end
end

# Wait for all threads to finish
threads.each { |t| t.join }

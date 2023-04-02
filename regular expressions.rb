# Find all occurrences of the word "example" in a string
string = "This is an example sentence. Another example."
matches = string.scan(/example/)
puts matches.inspect

# Find all email addresses in a string
string = "Contact us at john@example.com or jane@example.com"
emails = string.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)
puts emails.inspect

#!/usr/bin/env ruby

=begin

Use this script to monitor changes in performance when making code changes to Asciidoctor.

 $ ruby benchmark.rb <benchmark-name> <repeat>

The most common benchmark is the userguide-loop.
It will download the AsciiDoc User Guide automatically the first time, then convert it in memory.
Running it 10 times provides a good picture.

 $ ruby benchmark.rb userguide-loop 10

Only worry about the relative change to the numbers before and after the code change.
Absolute times are highly dependent on the capabilities of the machine the the version of Ruby.

To get the best results under MRI, tune Ruby using environment variables as follows:

.Ruby < 2.1
 $ RUBY_GC_MALLOC_LIMIT=90000000 RUBY_FREE_MIN=650000 ruby benchmark.rb userguide-loop 10

.Ruby >= 2.1
 $ RUBY_GC_MALLOC_LIMIT=128000000 RUBY_GC_OLDMALLOC_LIMIT=128000000 RUBY_GC_HEAP_INIT_SLOTS=10000000 RUBY_GC_HEAP_FREE_SLOTS=10000000 RUBY_GC_HEAP_GROWTH_MAX_SLOTS=250000 RUBY_GC_HEAP_GROWTH_FACTOR=2 ruby benchmark.rb userguide-loop 10
 $ RUBY_GC_MALLOC_LIMIT=128000000 RUBY_GC_OLDMALLOC_LIMIT=128000000 RUBY_GC_HEAP_INIT_SLOTS=20000000 RUBY_GC_HEAP_FREE_SLOTS=1000000 RUBY_GC_HEAP_GROWTH_MAX_SLOTS=250000 RUBY_GC_HEAP_GROWTH_FACTOR=2 ruby benchmark.rb userguide-loop 10

Asciidoctor starts with ~ 12,500 objects, adds ~ 300,000 each run, so tune RUBY_GC_HEAP_* accordingly

See http://globaldev.co.uk/2014/05/ruby-2-1-in-detail/#gc-tuning-environment-variables

Execute Ruby using the `--disable=gems` flag to speed up the initial load time, as shown below:

 $ ruby --disable=gems ...

=end

require 'benchmark'
include Benchmark

bench = ARGV[0]
$repeat = ARGV[1].to_i || 10000

if bench.nil?
  raise 'You must specify a benchmark to run.'
end

def fetch_userguide
  require 'open-uri'
  userguide_uri = 'https://raw.githubusercontent.com/asciidoc/asciidoc/d43faae38c4a8bf366dcba545971da99f2b2d625/doc/asciidoc.txt'
  customers_uri = 'https://raw.githubusercontent.com/asciidoc/asciidoc/d43faae38c4a8bf366dcba545971da99f2b2d625/doc/customers.csv'
  userguide_content = OpenURI.open_uri(userguide_uri) {|fd2| fd2.read }
  customers_content = OpenURI.open_uri(customers_uri) {|fd2| fd2.read }
  File.write 'sample-data/userguide.adoc', userguide_content, mode: 'w:utf-8'
  File.write 'sample-data/customers.csv', customers_content, mode: 'w:utf-8'
end

case bench

=begin
# benchmark template

when 'name'

  sample = 'value'

  Benchmark.bmbm(12) {|bm|
    bm.report('operation a') { $repeat.times { call_a_on sample } }
    bm.report('operation b') { $repeat.times { call_b_on sample } }
  }
=end

when 'userguide'
  require '../lib/asciidoctor.rb'
  Asciidoctor::Compliance.markdown_syntax = false
  Asciidoctor::Compliance.shorthand_property_syntax = false if Asciidoctor::VERSION > '0.1.4'
  sample_file = ENV['BENCH_TEST_FILE'] || 'sample-data/userguide.adoc'
  backend = ENV['BENCH_BACKEND'] || 'html5'
  fetch_userguide if sample_file == 'sample-data/userguide.adoc' && !(File.exist? sample_file)
  result = Benchmark.bmbm {|bm|
    bm.report(%(Convert #{sample_file} (x#{$repeat}))) {
      $repeat.times {
        Asciidoctor.render_file sample_file, :backend => backend, :safe => Asciidoctor::SafeMode::SAFE, :eruby => 'erubis', :header_footer => true, :to_file => false, :attributes => {'stylesheet' => nil, 'toc' => nil, 'numbered' => nil, 'icons' => nil, 'compat-mode' => ''}
      }
    }
  }
  # prints average for real run
  puts %(>avg: #{result.first.real / $repeat})

when 'userguide-loop'
  require '../lib/asciidoctor.rb'
  GC.start
  Asciidoctor::Compliance.markdown_syntax = false
  Asciidoctor::Compliance.shorthand_property_syntax = false if Asciidoctor::VERSION > '0.1.4'
  sample_file = ENV['BENCH_TEST_FILE'] || 'sample-data/userguide.adoc'
  backend = ENV['BENCH_BACKEND'] || 'html5'
  fetch_userguide if sample_file == 'sample-data/userguide.adoc' && !(File.exist? sample_file)

  timings = []
  2.times.each do
    loop_timings = []
    (1..$repeat).each do
      start = Time.now
      Asciidoctor.render_file sample_file, :backend => backend, :safe => Asciidoctor::SafeMode::SAFE, :eruby => 'erubis', :header_footer => true, :to_file => false, :attributes => { 'stylesheet' => nil, 'toc' => nil, 'numbered' => nil, 'icons' => nil, 'compat-mode' => '' }
      loop_timings << (Time.now - start)
    end
    timings << loop_timings
  end
  best_time = nil
  timings.each do |loop_timings|
    puts %(#{loop_timings * "\n"}\nRun Total: #{loop_timings.reduce :+})
    best_time = best_time ? [best_time, loop_timings.min].min : loop_timings.min
  end
  puts %(Best Time: #{best_time})

when 'mdbasics-loop'
  require '../lib/asciidoctor.rb'
  GC.start
  sample_file = ENV['BENCH_TEST_FILE'] || 'sample-data/mdbasics.adoc'
  backend = ENV['BENCH_BACKEND'] || 'html5'

  timings = []
  2.times do
    loop_timings = []
    (1..$repeat).each do
      start = Time.now
      Asciidoctor.render_file sample_file, :backend => backend, :safe => Asciidoctor::SafeMode::SAFE, :header_footer => false, :to_file => false, :attributes => { 'stylesheet' => nil, 'idprefix' => '', 'idseparator' => '-', 'showtitle' => '' }
      loop_timings << (Time.now - start)
    end
    timings << loop_timings
  end
  best_time = nil
  timings.each do |loop_timings|
    puts %(#{loop_timings * "\n"}\nRun Total: #{loop_timings.reduce :+})
    best_time = best_time ? [best_time, loop_timings.min].min : loop_timings.min
  end
  puts %(Best Time: #{best_time})

end

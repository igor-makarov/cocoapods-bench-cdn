require 'cocoapods'
require 'cocoapods-core'
require 'pry'
require 'benchmark'
require 'fileutils'

# Pod::UI.config.verbose = true

def measure(source, pods)
  time = Benchmark.measure do
    pods.each do |pod|
      source.versions(pod)
    end
  end
  STDERR.puts "#{source.name} #{time.real / pods.length} (#{pods.length} pods)"
end

def all_sources
  Dir['bench_repos/*'].map do |repo|
    Pod::CDNSource.new(repo)
  end
end

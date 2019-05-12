require 'cocoapods'
require 'cocoapods-core'
require 'pry'
require 'benchmark'
require 'fileutils'

module Pod
  module CoreUI
    @output = ''
    @warnings = ''

    class << self
      attr_accessor :output
      attr_accessor :warnings
    end

    def self.puts(message)
      # STDERR.puts message
    end

    def self.print(message)
      # STDERR.puts message
    end

    def self.warn(message)
      # STDERR.puts message
    end
  end
end

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

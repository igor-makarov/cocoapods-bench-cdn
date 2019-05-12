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
  FileUtils.rm_rf(source.specs_dir)
  time = Benchmark.measure do
    pods.each do |pod|
      source.versions(pod)
    end
  end
  STDERR.puts "#{source.name} #{time.real / pods.length} (#{pods.length} pods)"
end

jsdelivr = Pod::CDNSource.new('bench_repos/jsdelivr')
github = Pod::CDNSource.new('bench_repos/github')

sample_pods = jsdelivr.pods.sample(10).sort
 
measure(jsdelivr, sample_pods)
measure(github, sample_pods)

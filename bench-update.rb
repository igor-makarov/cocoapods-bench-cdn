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

jsdelivr = Pod::CDNSource.new('bench_repos/jsdelivr')
jsdelivr.instance_variable_set(:@check_existing_files_for_update, true)
github = Pod::CDNSource.new('bench_repos/github')
github.instance_variable_set(:@check_existing_files_for_update, true)

def measure(source, pods)
  time = Benchmark.measure do
    pods.each do |pod|
      source.versions(pod)
    end
  end
  STDERR.puts "#{source.name} #{time.real / pods.length} (#{pods.length} pods)"
end

sample_pods = Dir["#{jsdelivr.specs_dir.to_s}/?/?/?/*"].map { |p| File.basename(p) }.sort
 
measure(jsdelivr, sample_pods)
measure(github, sample_pods)

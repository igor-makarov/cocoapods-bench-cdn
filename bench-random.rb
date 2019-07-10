require './lib/common'
require 'cocoapods'
require 'cocoapods-core'
require 'pry'
require 'benchmark'
require 'fileutils'

sources = all_sources
sample_pods = sources.first.pods.sample(300).sort

all_sources.each do |source|
  FileUtils.rm_rf(source.specs_dir)
  measure(source, sample_pods)
end

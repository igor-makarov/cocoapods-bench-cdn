require './lib/common'
require 'cocoapods'
require 'cocoapods-core'
require 'pry'
require 'benchmark'
require 'fileutils'

sources = all_sources
metadata = sources.first.metadata
sample_pods = sources.first.pods.group_by { |pod|
  metadata.path_fragment(pod)[0..-2]
}.sort.map { |shard, pods| pods.first }


all_sources.each do |source|
  FileUtils.rm_rf(source.specs_dir)
  measure(source, sample_pods)
end

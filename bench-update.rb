require './lib/common'
require 'pry'
require 'benchmark'
require 'fileutils'

all_sources.each do |source|
  source.instance_variable_set(:@check_existing_files_for_update, true)
  sample_pods = Dir["#{source.specs_dir}/?/?/?/*"].map { |p| File.basename(p) }.sort
  measure_update(source, sample_pods)
end

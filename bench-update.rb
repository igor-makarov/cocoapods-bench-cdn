require './lib/common'
require 'pry'
require 'benchmark'
require 'fileutils'

jsdelivr = Pod::CDNSource.new('bench_repos/jsdelivr')
jsdelivr.instance_variable_set(:@check_existing_files_for_update, true)
github = Pod::CDNSource.new('bench_repos/github')
github.instance_variable_set(:@check_existing_files_for_update, true)

sample_pods = Dir["#{jsdelivr.specs_dir.to_s}/?/?/?/*"].map { |p| File.basename(p) }.sort
 
measure(jsdelivr, sample_pods)
measure(github, sample_pods)

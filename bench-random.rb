require './lib/common'
require 'cocoapods'
require 'cocoapods-core'
require 'pry'
require 'benchmark'
require 'fileutils'

jsdelivr = Pod::CDNSource.new('bench_repos/jsdelivr')
github = Pod::CDNSource.new('bench_repos/github')

sample_pods = jsdelivr.pods.sample(10).sort

FileUtils.rm_rf(jsdelivr.specs_dir)
measure(jsdelivr, sample_pods)

FileUtils.rm_rf(github.specs_dir)
measure(github, sample_pods)

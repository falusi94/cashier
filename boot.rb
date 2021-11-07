# frozen_string_literal: true

require 'bundler/setup'
groups_to_require = [:default]
groups_to_require << :test if ENV['TEST']
Bundler.require(*groups_to_require)

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/lib")
loader.setup

require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('generator_extensions', '0.1.0') do |p|
  p.description    = 'Functions that make it easier to write a Rails generator.'
  p.url            = 'http://github.com/heymarcel/rails_extensions'
  p.author         = 'Marcel Levy'
  p.email          = 'heymarcel@gmail.com'
  p.ignore_pattern = ['tmp/*', 'script/*']
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

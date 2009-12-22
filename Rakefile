require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "generator_extensions"
    gemspec.summary = 'Functions that make it easier to write a Rails generator.'
    gemspec.description = <<EOD
Generators can be a bit of a pain to write. This little gem smooths out 
some rough edges, by letting you mirror an entire directory in one line,
and providing convenience functions to add entire blocks of code
to pre-existing configuration files.
EOD
    gemspec.email = 'heymarcel@gmail.com'
    gemspec.homepage = 'http://github.com/heymarcel/generator_extensions'
    gemspec.authors = ['Marcel Levy']
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

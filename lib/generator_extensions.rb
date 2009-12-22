require 'find'

module RailsGeneratorExtensions

  def mirror(origin='mirror')
    directory_copy(origin, '')
  end

  def directory_copy(relative_source, relative_destination=nil)
    source = source_path(relative_source)
    relative_destination ||= relative_source
    path_to_delete = "#{source_root}/"

    Find.find(source) do |f|
      source = f.sub(path_to_delete, '')
      target = File.join(relative_destination, source.sub(relative_source, ''))
      case
      when File.file?(f)
        file source, target
      when File.directory?(f)
        directory target unless self.class.to_s.include? "Destroy"
      end
    end
  end

end

module Rails
  module Generator
    module Commands

      class Base
        include RailsGeneratorExtensions

        def add_to_routes(text)
          add_to_file('config/routes.rb',
                      'ActionController::Routing::Routes.draw do |map|',
                      text
                      )
        end

        def add_to_initializer(text)
          add_to_file('config/environment.rb',
                      'Rails::Initializer.run do |config|',
                      text)
        end

        def add_to_file(file, sentinel, text)
          first_line = text.split("\n")[0]
          m = /:in `([^']+)'$/.match(caller.first)
          logger.send(m[1].to_sym, first_line) if m
          unless options[:pretend]
            gsub_file file, /(#{Regexp.escape(sentinel)})/mi do |match|
              "#{match}\n#{text}\n"
            end
          end
        end

      end

      class Destroy < RewindBase
        include RailsGeneratorExtensions

        def add_to_routes(text)
          add_to_file('config/routes.rb', nil, text)
        end

        def add_to_initializer(text)
          add_to_file('config/environment.rb', nil, text)
        end

        def add_to_file(file, sentinel, text)
          first_line = text.split("\n")[0]
          logger.removing first_line
          gsub_file file, /(#{Regexp.escape(text)}\n)/mi, ''
        end

      end

    end
  end
end



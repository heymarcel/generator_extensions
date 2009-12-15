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
      end

      class Destroy < RewindBase
        include RailsGeneratorExtensions
      end

    end
  end
end



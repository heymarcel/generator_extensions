require 'find'

module Rails
  module Generator
    module Commands

      class Create < Base

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
              directory target
            end
          end
        end
      end
    end
  end
end

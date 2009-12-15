require 'find'

module Rails
  module Generator
    module Commands


      class Create < Base

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
              directory target
            end
          end
        end

      end


      # Lists a generator's action manifest
      class List < Base

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
              directory target
            end
          end
        end
      end

      # Undo the actions performed by a generator. Rewind the action
      # manifest and attempt to completely erase the results of each action.
      # Note that we're punting here when it comes to directories.
      class Destroy < RewindBase
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
              # Do nothing here, because the point is to use this to
              # mirror directories. We don't want to risk deleting
              # directories Rails needs.
            end
          end
        end


      end

    end
  end
end

module SimpleResource
  module FileIncluder
    ##
    #
    # This is an implementation of a C like include. You can use this at places where Puppet doesn't support parent-classed
    # like when defining Custum Types. include_file uses the already established search path. If you need to include a file
    # from a subdircetory, use the subdirectory name
    # 
    # Example:
    #  include_file 'puppet/types/ora'
    #
    # @param name [String] this is the name of the file to be included
    #
    #
    def include_file(name)
      file = get_file(name)
      raise ArgumentError, "file #{name} not found" unless file
      eval(IO.read(file))
    end

    private
      # @private
      def get_file(name)
        name = name + '.rb' unless name =~ /\.rb$/
        path = $LOAD_PATH.find { |dir| File.exist?(File.join(dir, name)) }
        path and File.join(path, name)
      end
    end
end

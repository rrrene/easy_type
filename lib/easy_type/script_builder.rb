module EasyType
	#
	# The command builder is a class that helps building an OS command sequence. You can specify 
	# a base command on creation. With the << you can add parameters and options in the order you would 
	# like. Sometimes you need to execute commands before and/or after the base command. The ScriptBuilder
	# supports this by using the `before` and `after` methods
	#
	class ScriptBuilder
		attr_reader :acceptable_commands, :entries

		class BlankSlate

			if RUBY_VERSION == "1.8.7"
				REQUIRED_METHODS = ['instance_eval', 'object_id', '__send__', '__id__']
			else
				REQUIRED_METHODS = [:instance_eval, :object_id, :__send__, :__id__]
			end
			instance_methods.each { |m| undef_method m unless REQUIRED_METHODS.include?(m) }

			def eigenclass 
		    class << self
		      self
		    end
	    end 


		end


		def initialize(options = {}, &block)
			@acceptable_commands = options.fetch(:acceptable_commands) {[]}
			@context = BlankSlate.new
			@entries = []

			@acceptable_commands.each do | command|
				@context.eigenclass.send(:define_method,command) do |*args|
					@entries << Struct.new(:command => command, :arguments => args)
				end
			end

			def default_command
				@acceptable_commands.first || ''
			end

		end

	end

end
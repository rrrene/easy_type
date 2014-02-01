module EasyType
	#
	# The command builder is a class that helps building an OS command sequence. You can specify 
	# a base command on creation. With the << you can add parameters and options in the order you would 
	# like. Sometimes you need to execute commands before and/or after the base command. The CommandBuilder
	# supports this by using the `before` and `after` methods
	#
	class CommandBuilder
		attr_accessor :command, :line
		attr_reader :before_results, :after_results, :options

		#
		# Initializes a new command builder.
		#
		# @param [Method] context the context into which the command is called. The context defines what 
		#                 properties and methods are available.
		# @param command  the de base command
		# @param line
		# @param options
		# @return [CommandBuilder] command_builder
		#
		def initialize(context, command, line = '', options = {})
			@context = context
			@command = translate_to_method(command)
			@before = []
			@after = []
			@line = line
			@before_results = []
			@after_results = []
			@options = options
		end

		#
		# @param line the part that is added to the base command
		# @return [CommandBuilder] command_builder
		#
		def <<(line)
			@line << ' ' << line
			self
		end

		#
		# @param command The command to be geving before the main command
		#
		def before(command = nil)
			if command
				@before << command
				self
			else
				@before
			end
		end

		#
		# @param command The command to be geving after the main command
		#
		def after(command = nil)
			if command
				@after << command
				self
			else
				@after
			end
		end

		#
		# Execute all the commands given. First the before commands, then the main command, and last the
		# after commands.
		#
		def execute
			@before.each do | before|
				@before_results << @command.call(before, @options)
			end
			value = @command.call(@line, @options ) if @line
			@after.each do | after|
				@after_results << @command.call(after, @options)
			end
			value
		end

		private

		# @private
		def translate_to_method(method_identifier)
			case  method_identifier.class.to_s
				when 'Symbol', 'String'
					valid_method_for(method_identifier.to_sym)
				when 'Method'
					method_identifier
			else 
				fail("easy_type: invalid method identifier passed to command builder")
			end
		end

		# @private
		def valid_method_for(method_identifier)
			method_identifier = method_identifier.to_s if RUBY_VERSION == "1.8.7"
			unless @context.methods.include?(method_identifier) 
				fail "easy_type: unknown method identifier passed to command builder"
			end
			@context.method(method_identifier)
		end

	end
end
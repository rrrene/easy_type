module EasyType
	class CommandBuilder
		attr_accessor :command, :line
		attr_reader :before_results, :after_results, :options

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

		def <<(line)
			@line << ' ' << line
			self
		end

		def before(command = nil)
			if command
				@before << command
				self
			else
				@before
			end
		end

		def after(command = nil)
			if command
				@after << command
				self
			else
				@after
			end
		end

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

		def valid_method_for(method_identifier)
			method_identifier = method_identifier.to_s if RUBY_VERSION == "1.8.7"
			unless @context.methods.include?(method_identifier) 
				fail "easy_type: unknown method identifier passed to command builder"
			end
			@context.method(method_identifier)
		end

	end
end
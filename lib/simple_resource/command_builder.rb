module SimpleResource
	class CommandBuilder
		attr_accessor :command, :line
		attr_reader :before_results, :after_results, :options

		def initialize(context, command, line = '', options = {})
			@context = context
			@command = command
			@line = line
			@before_results = nil
			@after_results = nil
			@options = options
		end

		def <<(line)
			@line << ' ' << line
			self
		end

		def before(command = nil)
			if command
				@before = command
				self
			else
				@before
			end
		end

		def after(command = nil)
			if command
				@after = command
				self
			else
				@after
			end
		end

		def execute
			@before_results = @context.send(@command, @before, @options) if @before
			value = @context.send(@command, @line, @options )
			@after_results = @context.send(@command, @after, @options) if @after
			value
		end

	end
end
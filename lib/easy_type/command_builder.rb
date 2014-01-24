module EasyType
	class CommandBuilder
		attr_accessor :command, :line
		attr_reader :before_results, :after_results, :options

		def initialize(context, command, line = '', options = {})
			@context = context
			@command = command
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
				@before_results << execute_method_or_host_command(@command, before, @options)
			end
			value =execute_method_or_host_command(@command, @line, @options ) if @line
			@after.each do | after|
				@after_results << execute_method_or_host_command(@command, after, @options)
			end
			value
		end

		private

		def execute_method_or_host_command(command_or_host_command, line, options)
			method?(command_or_host_command) ? execute_method(command_or_host_command, line, options) : 
				execute_host_command(command_or_host_command, line, options)
		end

		def method?(method_or_command)
			method_or_command = method_or_command.to_s if RUBY_VERSION == "1.8.7"
			@context.methods.include?(method_or_command)
		end

		def execute_method(method, line, options)
			@context.send(command, line, options)
		end

		def execute_host_command(host_command, line, options)
			Puppet::Util::Execution.execute [host_command, line]
		end


	end
end
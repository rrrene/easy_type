class CommandEntry

	attr_reader :command, :arguments, :context

	def self.set_binding(the_binding)
		@@binding = the_binding
	end

	def initialize(command, arguments)
		@command = command
		@arguments = arguments.collect{|e| e.split(' ')}.flatten
	end


	def execute
		normalized_command = RUBY_VERSION == "1.8.7" ? command.to_s : command.to_sym
		if @@binding.methods.include?(normalized_command)
			@@binding.send(normalized_command, *arguments.join(' '))
		else
			full_command = arguments.dup.unshift(command) 
			Puppet::Util::Execution.execute(full_command,:failonfail => true)
		end
	end

end

require 'easy_type/command_entry'
require 'easy_type/blank_slate'

module EasyType
	#
	# The command builder is a class that helps building an OS command sequence. You can specify 
	# a base command on creation. With the << you can add parameters and options in the order you would 
	# like. Sometimes you need to execute commands before and/or after the base command. The ScriptBuilder
	# supports this by using the `before` and `after` methods
	#
	class ScriptBuilder


		attr_reader :acceptable_commands, :binding

		def initialize(options = {}, &block)
			@entries ||= []
			@acceptable_commands = Array(options.fetch(:acceptable_commands) {[]})
			@binding = options[:binding]
			@context = BlankSlate.new
			if @binding
				CommandEntry.set_binding(@binding)
				copy_resource_info
			end
			@acceptable_commands.each do | command|
				@context.eigenclass.send(:define_method,command) do |*args|
					@entries[type] << CommandEntry.new(command, args)
				end
			end
			@context.type = :main
			@context.instance_eval(&block) if block
		end

		def entries(type = :main)
			@context.entries[type]
		end

		def default_command
			@acceptable_commands.first || ''
		end

		def last_command(type = :main)
			entries(type).last
		end

		def add(*args, &block)
			if block
				add_to_queue(:main, &block)
				nil
			else
				entries(:main) << CommandEntry.new(default_command, args) unless args == [nil] #special case
			end
		end

		def <<(line)
			raise ArgumentError, 'no command specified' unless last_command
			last_command.arguments << line
		end

		def before(&block)
			add_to_queue(:before, &block)
		end

		def after(&block)
			add_to_queue(:after, &block)
		end

		def execute
			@context.execute
			results
		end

		def results(type = :main)
			@context.results[type].join("\n")
		end

		private

			def add_to_queue(queue, &block)
				raise ArgumentError, 'block must be present' unless block
				@context.type = queue
				@context.instance_eval(&block)
			end

			def copy_resource_info
				return unless @binding.respond_to?(:to_hash)
				@binding.to_hash.each_pair do | key, value|
					@context.eigenclass.send(:define_method,key) do 
						value
					end
				end
			end

	end

end
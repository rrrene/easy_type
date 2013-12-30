require 'simple_resource/version'
require 'simple_resource/parameter'
require 'simple_resource/type'
require 'simple_resource/parameter'
require 'simple_resource/mungers'
require 'simple_resource/validators'
require 'simple_resource/provider'
require 'simple_resource/file_includer'
require 'simple_resource/command_builder'

module SimpleResource
	def self.included(parent)
		if parent.ancestors.include?(Puppet::Type)
			parent.send(:include, SimpleResource::Type)
		end
		if parent.ancestors.include?(Puppet::Parameter)
			parent.send(:include, SimpleResource::Parameter)
		end
		parent.extend SimpleResource::FileIncluder
	end
end

require 'easy_type/group_methods'

module EasyType

	#
	# This module contains all extensions used by EasyType within the type
	#
	# To use it, include the following statement in your type
	#
	#  	include EasyType::Type
	#
	module Type
		def self.included(parent)
			parent.extend(ClassMethods)
		end

		module ClassMethods
			#
			# define a group of parameters. A group means a change in one of
			# it's members all the information in the group is added tot 
			# the command
			#
			# example:
			#  group(:name) do # name is optional
			# 		property :a
			# 		property :b
			#	 end
			#
			def group(group_name = :default, &block)
				include EasyType::FileIncluder
				include EasyType::GroupMethods

			  @group_name = group_name # make it global
				@groups ||= {}
				yield if block
			end
			#
			# include's the parameter declaration
			#
			# example:
			#  parameter(:name)
	    #
			#
			def parameter(parameter_name)
				include_file "puppet/type/#{name}/#{parameter_name}"
			end
			alias_method :property, :parameter

			#
			# set's the command to be executed
			#
			# example:
			#  newtype(:oracle_user) do
			#
			#    command do
		  #	    :sql
	    #    end
	    #
			#
			def set_command(method)
				define_method(:command) do
					method
				end
			end
			#
			# retuns the string needed to start the creation of an sql type
			#
			# example:
			#  newtype(:oracle_user) do
			#
			#    on_create do
		  #	    "create user #{self[:name]}"
	    #    end
	    #
			#
			def on_create(&block)
				define_method(:on_create, &block) if block
			end

			#
			# retuns the string needed to remove an sql type
			#
			# example:
			#  newtype(:oracle_user) do
			#
			#    on_destroy do
		  #	    "drop user #{self[:name]}"
	    #    end
	    #
			#
			def on_destroy(&block)
				define_method(:on_destroy, &block) if block
			end

			#
			# retuns the string needed to alter an sql type
			#
			# example:
			#  newtype(:oracle_user) do
			#
			#    on_modify do
		  #	    "alter user #{self[:name]}"
	    #    end
	    #
			#
			def on_modify(&block)
				define_method(:on_modify, &block) if block
			end

			#
			# TODO: Fill with right description
			#
			# example:
			#  newtype(:oracle_user) do
			#
			#    to_get_raw_resourced do
			#   	TODO: Fill in
	    #    end
	    #
			#
			def to_get_raw_resources(&block)
				eigenclass = class << self; self; end
				eigenclass.send(:define_method, :get_raw_resources, &block)
			end
		end
	end
end
module EasyType
	module GroupMethods

		def self.included(parent)
			parent.extend(ClassMethods)
		end

		module ClassMethods

		  def method_missing(method_sym, *arguments, &block)
		  	fail "only parameter and property commands allowed in group"
		  end

		  def parameter(parameter_name)
		  	@groups.merge!(@group_name => include_file("puppet/type/#{name}/#{parameter_name}"))
		  end

		  def property(property_name)
		  	@groups.merge!(@group_name => include_file("puppet/type/#{name}/#{property_name}"))
		  end
		end
	end
end

module EasyType
	module GroupMethods

		def self.included(parent)
			parent.extend(ClassMethods)
		end

		module ClassMethods

		  def parameter(parameter_name)
		  	process_group_entry(include_file("puppet/type/#{name}/#{parameter_name}"))
		  end

		  def property(property_name)
		  	process_group_entry(include_file("puppet/type/#{name}/#{property_name}"))
		  end

		  private

		  def process_group_entry(entry)
		  	check_if_group_is_a_hash
		  	make_entry_for(name)
		  	add_entry_for(name, entry)
		  end

		  def check_if_group_is_a_hash
		  	fail "internal error, groups array must exist" unless @groups.is_a? Hash
		  end

		  def make_entry_for(name)
		  	@groups.fetch(name) { @groups[name] = [] }
		  end

		  def add_entry_for(name, parameter)
		  	group = @groups.fetch(name) { fail "Internal error. group not found"}
		  	group << parameter
		  end

		end
	end
end

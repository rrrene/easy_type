[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/hajee/simple_resource/trend.png)](https://bitdeli.com/free "Bitdeli Badge")[![Code Climate](https://codeclimate.com/github/hajee/simple_resource.png)](https://codeclimate.com/github/hajee/simple_resource) [![Build Status](https://travis-ci.org/hajee/simple_resource.png)](https://travis-ci.org/hajee/simple_resource) [![Dependency Status](https://gemnasium.com/hajee/simple_resource.png)](https://gemnasium.com/hajee/simple_resource) [![Coverage Status](https://coveralls.io/repos/hajee/simple_resource/badge.png)](https://coveralls.io/r/hajee/simple_resource)


simple_resource
===============
This module makes it easier to create custom types. To create a custom type use:

```ruby
require 'simple_resource'

module Puppet
  #
  # Create a new type oracle_user. Oracle user, works in conjunction 
  # with the SqlResource provider
  #
  newtype(:a_custom_type) do
    include SimpleResource

    ensurable
    #
    # Use set_command to set the base command given on createing, destroying and modifying 
    # the resource
    #
    set_command(:just_a_method)


    to_get_raw_resources do
    	#
    	# Fill in the code needed to get an array of reseources. The array must contain Hashes
    	# the Hash can have arbitrary elements. 
    	#

    end

    on_create do
			# this is the statement that is added to the command (see set_command) to create a resource
			# You can reference all type information using self[:attr] where :attr is a parameter or property 
			# of the type 
      "create user #{self[:name]}"
    end

    on_modify do
			# this is the statement that is added to the command (see set_command) to modify a resource
			# You can reference all type information using self[:attr] where :attr is a parameter or property 
			# of the type 
      "alter user #{self[:name]}"
    end

    on_destroy do
			# this is the statement that is added to the command (see set_command) to destroy a resource
			# You can reference all type information using self[:attr] where :attr is a parameter or property 
			# of the type 
      "drop user #{self[:name]}"
    end

    newparam(:name) do
      include SimpleResource
      include SimpleResource::Validators::Name 	# Check simple_resource/validators for available validators
      include SimpleResource::Mungers::upcase   # Check simple_resource/validators for available mungers

      desc "The user name"

      isnamevar

      #
      # Use this method to pick a part for the raw_resource hash. and translate it to the real resource hash
      #
      to_translate_to_resource do | raw_resource|
        raw_resource['USERNAME'].upcase
      end


    end

    newproperty(:user_id) do
      include SimpleResource

      include SimpleResource::Validators::Integer 	# Check simple_resource/validators for available validators
      include SimpleResource::Mungers::Integer			# Check simple_resource/validators for available mungers

      desc "The user id"

      #
      # Use this method to pick a part for the raw_resource hash. and translate it to the real resource hash
      #
      to_translate_to_resource do | raw_resource|
        raw_resource['USER_ID'].to_i
      end

      #
      # Use this method to append specific information for a porperty to the create or the update commands
      #
      on_apply do
        "default tablespace #{resource[:default_tablespace]}"
      end

    end

  end
end

```

to use this resource, You must add the next file into the provider directory

```ruby
require 'simple_resource'

Puppet::Type.type(:a_custom_type).provide(:simple) do
  include SimpleResource::Provider

  mk_resource_methods

end
```


License
-------

MIT License


Contact
-------
Bert Hajee hajee@moretIA.com

Support
-------
Please log tickets and issues at our [Projects site](https://github.com/hajee/simple_resource)

require 'puppet/patches/parameter'
require 'puppet/patches/type'
require 'utils/validators'
require 'utils/mungers'
require 'utils/file_includer'

module Puppet
  #
  # Create a new type oracle_user. Oracle user, works in conjunction 
  # with the SqlResource
  #
  newtype(:grant) do


    to_get_raw_resources do
      #
      # Use this method to get the information in raw form. This method must retsurn
      # an array. For every instance of the resource available, an entry must be created
      # 
    end

    on_create do
      #
      #
      #
    end

    on_modify do
      #
      #
      # 
    end

    on_destroy do
      #
      #
      #
    end

    newparam(:name) do
      include ::Utils::Validators::NameValidator
      desc "The user name for the rights"

      isnamevar

      to_translate_to_resource do | raw_resource|
      	raw_resource[:username]
      end

    end

    newproperty(:grants, :array_matching => :all) do
    	include ::Utils::Mungers::Upcase
      desc "The right(s) to grant"

      to_translate_to_resource do | raw_resource|
      	raw_resource[:grants]
      end

      on_apply do
      end

    end

  end
end



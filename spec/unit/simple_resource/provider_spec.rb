#!/usr/bin/env ruby

require 'spec_helper'
require 'simple_resource'
require 'puppet'

	module Puppet
	  newtype(:test) do
	  	include SimpleResource

	    to_get_raw_resources do
	    end

	    on_create do
	    	"on_create"
	    end

	    on_modify do
	    	"on_modify"
	    end

	    on_destroy do
	    	"on_destroy"
	    end

	    newparam(:name) do
		  	include SimpleResource
	      include SimpleResource::Validators::Name

	      isnamevar

	      to_translate_to_resource do | raw_resource|
	      	raw_resource[:username]
	      end

	      on_apply do
	      	"name attribute applied"
	      end

	    end

	  end
  end


describe SimpleResource::Provider do


end


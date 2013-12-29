#!/usr/bin/env ruby

require 'spec_helper'
require 'simple_resource/validators'

describe SimpleResource::Validators::Name do
	include SimpleResource::Validators::Name

	it "does nothing on a valid name string" do
		expect(validate('bert')).to eql nil
	end

	it "raises ArgumentError on empty string" do
		expect{validate('')}.to raise_error(Puppet::Error)
	end


	it "raises ArgumentError on string with whitespace" do
		expect{validate('bert hajee')}.to raise_error(Puppet::Error)
	end

end


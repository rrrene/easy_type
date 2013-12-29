#!/usr/bin/env ruby

require 'spec_helper'
require 'simple_resource/file_includer'

describe SimpleResource::FileIncluder do
	include SimpleResource::FileIncluder

	context "a file does exist" do

		before do
			include_file "simple_resource/include_check.rb"
		end

		it "evaluates the ruby code in the file" do
			expect(file_is_included).to be true
		end
	end


	context "a file does not exist" do

		it "raises an ArgumentError" do
			expect{ include_file "simple_resource/nonexisting_file.rb"}.to raise_error(ArgumentError)
		end
	end

end


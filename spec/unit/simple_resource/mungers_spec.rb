#!/usr/bin/env ruby

require 'spec_helper'
require 'simple_resource/mungers'

describe SimpleResource::Mungers::Integer do
	include SimpleResource::Mungers::Integer

	it "returns an integer when given an integer like string" do
		expect(munge('1')).to eql 1
	end

	it "raises ArgumentError on floating number string" do
		expect{munge('1.3')}.to raise_error(ArgumentError)
	end

	it "raises ArgumentError on a character string" do
		expect{munge('bert')}.to raise_error(ArgumentError)
	end

end

describe SimpleResource::Mungers::Size do
	include SimpleResource::Mungers::Size

	it "returns an integer when given an integer like string" do
		expect(munge('100')).to eql 100
	end

	it "returns an integer * 1024 when it an 'K' is appended" do
		expect(munge('100K')).to eql 102400
	end

	it "returns an integer * 1024 * 1024 when it an 'M' is appended" do
		expect(munge('100M')).to eql 104857600
	end

	it "raises RuntimeError on floating number string" do
		expect{munge('1.3')}.to raise_error(RuntimeError)
	end

end

describe SimpleResource::Mungers::Upcase do
	include SimpleResource::Mungers::Upcase

	it "returns an lowercase version of the input when it contains non-capitals" do
		expect(munge('Hallo')).to eql 'HALLO'
	end
	it "returns an the same value if string contains only capitals" do
		expect(munge('HALLO')).to eql 'HALLO'
	end

end

describe SimpleResource::Mungers::Downcase do
	include SimpleResource::Mungers::Downcase

	it "returns an lowercase version of the input when it contains capitals" do
		expect(munge('Hallo')).to eql 'hallo'
	end
	it "returns an the same value if string contains no capitals" do
		expect(munge('hallo')).to eql 'hallo'
	end


end

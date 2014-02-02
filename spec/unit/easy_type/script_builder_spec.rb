#!/usr/bin/env ruby

require 'spec_helper'
require 'easy_type/script_builder'


describe EasyType::ScriptBuilder do

	subject { described_class.new(options) }

	context "no options passed" do
		let(:options) {{}}

		it "has no default command" do
			expect(subject.default_command).to be_empty
		end

		it "has no acceptable commands" do
			expect(subject.acceptable_commands).to be_empty
		end

		it_behaves_like "has no entries"

	end

	context "acceptable commands passed as options" do

		let(:options) { {:acceptable_commands => [:first, :second]} }

		it "acceptable_commands is set" do
			expect(subject.acceptable_commands).to eq([:first, :second])
		end


		it "has a default command" do
			expect(subject.default_command).to eq(:first)
		end

		it_behaves_like "has no entries"

	end

	# context "a block with acceptable commands passed" do

	# 	subject do 
	# 		described_class.new(options) do 
	# 		end
	# 	end

	# 	let(:options) { {:acceptable_commands => [:first]} }

	# 	it_behaves_like "a block with acceptable commands passed"

	# end


end
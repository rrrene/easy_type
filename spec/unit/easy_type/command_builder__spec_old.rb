#!/usr/bin/env ruby

require 'spec_helper'
require 'easy_type/command_builder'


describe EasyType::CommandBuilder do

	before do
		def command
			"just a command"
		end
	end

	describe ".new" do

		context "a valid method passed as a symbol" do
			subject { described_class.new(self, :command) }

			it "sets the command" do
				expect(subject.command).to eq method(:command)
			end
		end

		context "a valid method passed as a string" do
			subject { described_class.new(self, 'command') }

			it "sets the command" do
				expect(subject.command).to eq method(:command)
			end
		end

		context "an unkown method passed" do
			subject { described_class.new(self, :unkown_command) }

			it "raises an error" do
				expect{subject.command}.to raise_error
			end
		end

		context "an invalid method identifier passed" do
			subject { described_class.new(self, 200) }

			it "raises an error" do
				expect{subject.command}.to raise_error
			end
		end

		context "options passed" do
			subject {described_class.new(self, :command, '', :option_a => 1, :option_b => true) }

			it "sets the command" do
				expect(subject.command).to eq method(:command)
			end

			it "sets the options" do
				expect(subject.options).to eq({:option_a => 1, :option_b => true})
			end
		end

	end


	describe "#<<(parameter)" do

		let(:command_builder) {described_class.new(self, :command, 'line')}
		subject {command_builder << 'appended'}

		it "appends the parameter to the existing line" do
			expect(subject.line).to eq('line appended')
		end
	end


	describe "#before" do

		let(:command_builder) {described_class.new(self, :command)}
		subject {command_builder.before('before')}

		it "sets the before command" do
			expect(subject.before).to eq(['before'])
		end
	end



	describe "#after" do

		let(:command_builder) {described_class.new(self, :command)}
		subject {command_builder.after('after')}

		it "sets the after command" do
			expect(subject.after).to eq(['after'])
		end
	end

	describe "#execute" do

			before do
				def dummy_command(value, options)
					"#{value}"
				end
			end

			let(:command_builder) {described_class.new(self, :dummy_command, "main\n")}
			subject {command_builder.execute}


			context "no before & no after set" do

				it_behaves_like "executes the command with the line" 
				it_behaves_like "no before results set"
				it_behaves_like "no after results set"
			end

			context "with before & with after set" do

				before do
					command_builder.after("after\n")
					command_builder.before("before\n")
				end

				it_behaves_like "executes the command with the line" 
				it_behaves_like "before results set"
				it_behaves_like "after results set"

			end


	end

end
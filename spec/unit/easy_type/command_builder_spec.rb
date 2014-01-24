#!/usr/bin/env ruby

require 'spec_helper'
require 'easy_type/command_builder'


describe EasyType::CommandBuilder do

	describe ".new" do

		context "do options passed" do
			subject {described_class.new(self, :command) }

			it "sets the command" do
				expect(subject.command).to eq(:command)
			end
		end

		context "options passed" do
			subject {described_class.new(self, :command, '', :option_a => 1, :option_b => true) }

			it "sets the command" do
				expect(subject.command).to eq(:command)
			end

			it "sets the options" do
				expect(subject.options).to eq({:option_a => 1, :option_b => true})
			end
		end

	end


	describe "#<<(parameter)" do

		let(:command) {described_class.new(self, :command, 'line')}
		subject {command << 'appended'}

		it "appends the parameter to the existing line" do
			expect(subject.line).to eq('line appended')
		end
	end


	describe "#before" do

		let(:command) {described_class.new(self, :command)}
		subject {command.before('before')}

		it "sets the before command" do
			expect(subject.before).to eq(['before'])
		end
	end



	describe "#after" do

		let(:command) {described_class.new(self, :command)}
		subject {command.after('after')}

		it "sets the after command" do
			expect(subject.after).to eq(['after'])
		end
	end

	describe "#execute" do

		context "command set to a local method" do

			before do
				def dummy_command(value, options)
					"#{value}"
				end
			end

			let(:command) {described_class.new(self, :dummy_command, "main\n")}
			subject {command.execute}


			context "no before & no after set" do

				it_behaves_like "executes the command with the line" 
				it_behaves_like "no before results set"
				it_behaves_like "no after results set"
			end

			context "with before & with after set" do

				before do
					command.after("after\n")
					command.before("before\n")
				end

				it_behaves_like "executes the command with the line" 
				it_behaves_like "before results set"
				it_behaves_like "after results set"

			end
		end


		context "command set to a non existing method" do

			let(:command) {described_class.new(self, :echo, 'main')}
			subject {command.execute}


			context "no before & no after set" do

				it_behaves_like "executes the command with the line" 
				it_behaves_like "no before results set"
				it_behaves_like "no after results set"
			end

			context "with before & with after set" do

				before do
					command.after('after')
					command.before('before')
				end

				it_behaves_like "executes the command with the line" 
				it_behaves_like "before results set"
				it_behaves_like "after results set"

			end
		end



	end

end
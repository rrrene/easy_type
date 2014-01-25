shared_examples "executes the command with the line" do

	it "executes the command with the line" do
		expect(subject).to eql("main\n")
	end
end


shared_examples "no before results set" do

	it "no before results set" do
		subject
		expect(command_builder.before_results).to be_empty
	end
end

shared_examples "no after results set" do

	it "no after results set" do
		subject
		expect(command_builder.after_results).to be_empty
	end
end

shared_examples "before results set" do

	it "before results set" do
		subject
		expect(command_builder.before_results).to eql(["before\n"])
	end
end

shared_examples "after results set" do
	it "after results set" do
		subject
		expect(command_builder.after_results).to eql(["after\n"])
	end
end


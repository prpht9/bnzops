
Given('I reset my options') do
  @args = []
  @responses = {}
end

Given('I add action {string}') do |string|
  @args << string
end

Given('I add the option {string}') do |string|
  @args << string
end

Given('I Answer {string}') do |string|
  @input.string = string
end

When('I execute bnzops') do
  cli = BNZOps::CLI.new({highline: {input: @input, output: @output}})
end

Then('My output should contain {string}') do |string|
  rx = eval("/#{string}/")
  cli = BNZOps::CLI.new({highline: {input: @input, output: @output}})
  expect {cli.start(@args)}.to output(rx).to_stdout
end

Then('My Exit code should be {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end


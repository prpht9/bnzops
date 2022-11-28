require 'rspec'
require_relative '../../lib/bnzops'
require_relative '../../lib/bnzops/cli'

Before do |scenario|
  @input    = StringIO.new
  @output   = StringIO.new
  @highline = HighLine.new(@input, @output)

  #@question = HighLine::Question.new("How are you?", nil)
  #@asker    = HighLine::QuestionAsker.new(@question, @highline)
end

After do |scenario|
end

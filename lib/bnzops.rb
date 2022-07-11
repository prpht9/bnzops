module BNZOps
end

require_relative 'bnzops/strategy'
require_relative 'bnzops/cli'

require_relative '../config/questionnaires.rb'

QUESTIONNAIRES.each do |name|
  require_relative "../strategy/#{name}"
end

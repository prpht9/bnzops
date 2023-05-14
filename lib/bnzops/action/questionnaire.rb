require 'highline'
require 'yaml'
require_relative '../../../config/defaults.rb'

class BNZOps::Action::Questionnaire

  def walk_questionnaire()
    @questionnaire.each do |entry|
      q_key, q = entry
      next if skip?(entry)
      @cli.say q[:description]
      answer = @cli.ask("#{q[:question]}  ", Integer) {|a| a.in = q[:validation] }
      if q[:answer_type] == :literal
        @config[q_key] = answer
      else
        @config[q_key] = q[:answers][answer - 1]
      end
    end
  end

  def skip?(entry)
    q_key, q = entry
    if q.include? :skip_trigger
      trigger, v = q[:skip_trigger]
        if eval(trigger) == v
          @config[q_key] = q[:skip_answer]
          return true
        else
        end
      #end
    else
      return false
    end
  end

end


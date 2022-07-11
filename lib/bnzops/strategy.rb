require 'highline'
require 'yaml'
require_relative '../../config/defaults.rb'

module BNZOps::Strategy

  SUBNET_LENGTH = 256

  @@registry = [
  ]

  def self.register(klass)
    @@registry << [klass]
  end

  def self.registry
    return @@registry
  end

  def strategy_setup()
    @cli = HighLine.new
    @strategy = {}
    @questionnaire = {}
  end

  def strategy()
    return @strategy
  end

  def strategy=(strategy)
    @strategy = strategy
  end

  def questionnaire()
    return @questionnaire
  end

  def questionnaire=(questionnaire)
    @questionnaire = questionnaire
  end

  def self.walk_registry()
    @@registry.each do |klass|
      s = klass.new
      self.walk_questionnaire(s.questionnaire)
    end
  end

  def self.walk_questionnaire(yml_questionnaire)
    yml_questionnaire.each do |entry|
      q_key, q = entry
      next if skip?(entry)
      @cli.say q[:description]
      answer = @cli.ask("#{q[:question]}  ", Integer) {|a| a.in = q[:validation] }
      if q[:answer_type] == :literal
        @strategy[q_key] = answer
      else
        @strategy[q_key] = q[:answers][answer - 1]
      end
    end
  end

  def save_strategy()
    puts @strategy.inspect
    filename = @cli.ask("Strategy filename?  ") {|a| a.default = "./strategy.yml"}
    puts "Saving Strategy to: #{filename}"
    f = File.open(filename, 'w')
    begin
      f.write(@strategy.to_yaml)
      f.close
      puts "Strategy saved to #{filename}"
    rescue StandardError => e
      puts "Error writing #{filename}: #{e.inspect}"
    end
  end

  private

  def skip?(entry)
    q_key, q = entry
    if q.include? :skip_trigger
      trigger, v = q[:skip_trigger]
      if eval(trigger) == v
        @strategy[q_key] = q[:skip_answer]
        return true
      end
    else
      return false
    end
  end

end


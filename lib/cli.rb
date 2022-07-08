require 'highline'
require 'yaml'
require_relative '../config/defaults.rb'
require_relative '../config/questionnaire.rb'

module BZOps
end

class BZOps::Cli

  SUBNET_LENGTH = 256

  def initialize()
    @cli = HighLine.new
    @config = {}
    @networks = []
  end

  def show_banner()
  end

  def walk_questionnaire()
    QUESTIONNAIRE.each do |entry|
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

  def show_results()
    puts @config.inspect
    filename = @cli.ask("Configuration filename?  ") {|a| a.default = "./strategy.yml"}
    puts "Saving configuration to: #{filename}"
    f = File.open(filename, 'w')
    begin
      f.write(@config.to_yaml)
      f.close
      puts "Configuration saved to #{filename}"
    rescue StandardError => e
      puts "Error writing #{filename}: #{e.inspect}"
    end
  end

  def load_networks()
    c = @config
    c[:ips_per_subnet] = SUBNET_LENGTH / c[:vpc_per_slash_16]
    c[:networks] = []
    c[:count].times do
      c[:vpc_per_slash_16].times do
        c[:networks] << "#{c[:octet1]}.#{c[:octet2]}.#{c[:octet3]}.#{c[:octet4]}"
        c[:octet3] = c[:octet3] + c[:ips_per_subnet]
      end
      c[:octet2] = c[:octet2] + 1
      c[:octet3] = 0
    end
    #when 1
    #  while @networks.flatten.length < c[:count]
    #    nets = []
    #    while nets.length < c[:vpc_per_slash_16]
    #      
    #      net = "#{c[:octet1]}.#{c[:octet2] + @networks.length}.#{c[:octet3]}.#{c[:octet4]}/#{c[:netmask]}"
    #      nets << net
    #    end
    #    @networks << nets
    #  end
    #when 2
    #  while @networks.length < c[:count]
    #    net = "#{c[:octet1]}.#{c[:octet2] + @networks.length}.#{c[:octet3]}.#{c[:octet4]}/#{c[:netmask]}"
    #    @networks << net
    #  end
    #end
  end

  def show_networks()
    puts @config.inspect
    filename = @cli.ask("Networks filename?  ") {|a| a.default = "./networks.yml"}
    puts "Saving networks to: #{filename}"
    f = File.open(filename, 'w')
    begin
      f.write(@config.to_yaml)
      f.close
      puts "Networks saved to #{filename}"
    rescue StandardError => e
      puts "Error writing #{filename}: #{e.inspect}"
    end
  end

  def calc_vpc_per_slash_16()
    c = @config
    case c[:net_size]
    when 12
      c[:vpc_per_slash_16] = 1
      c[:netmask] = 16
      c[:octet_end] = c[:octet_start] + 15
    when 13
      if c[:count] == 8
        c[:vpc_per_slash_16] = 1
        c[:netmask] = 16
      else
        c[:vpc_per_slash_16] = 2
        c[:netmask] = 17
      end
      c[:octet_end] = c[:octet_start] + 7
    when 14
      if c[:count] == 8
        c[:vpc_per_slash_16] = 2
        c[:netmask] = 17
      else
        c[:vpc_per_slash_16] = 4
        c[:netmask] = 18
      end
      c[:octet_end] = c[:octet_start] + 3
    when 15
      if c[:count] == 8
        c[:vpc_per_slash_16] = 4
        c[:netmask] = 18
      else
        c[:vpc_per_slash_16] = 8
        c[:netmask] = 19
      end
      c[:octet_end] = c[:octet_start] + 1
    when 16
      if c[:count] == 8
        c[:vpc_per_slash_16] = 8
        c[:netmask] = 19
      else
        c[:vpc_per_slash_16] = 16
        c[:netmask] = 20
      end
      c[:octet_end] = c[:octet_start]
    end
    load_networks()
  end

  def calc_vpcs()
    c = @config
    #case c[:net_size]
    #when 12
      #DEFAULTS[:region_order].each do |vpc_name|
      #end
      puts "Octet1: #{c[:octet1]}"
      puts "Octet2: #{c[:octet2]}"
      puts "Octet3: #{c[:octet3]}"
      puts "Octet4: #{c[:octet4]}"
      puts "Count: #{c[:count]}"
    #end
  end

  def build_configuration()
    determine_network()
    determine_vpcs()
  end

  def determine_network()
    c = @config
    c[:net_size] = DEFAULTS[c[:network_size]][:net_size]
    c[:count] = DEFAULTS[c[:network_size]][:count]
    c[:vpc_size] = DEFAULTS[c[:network_size]][:vpcc_size]
    c[:network] = "#{c[:private_network]}.#{c[:octet_start]}.0.0/#{c[:net_size]}"
    c[:octet1] = c[:private_network].to_i
    c[:octet2] = c[:octet_start].to_i
    c[:octet3] = 0
    c[:octet4] = 0
    puts "Network: #{c[:network]}"
  end

  def determine_vpcs()
    c = @config
    calc_vpc_per_slash_16()
    puts "End Octet: #{c[:octet_end]}"
    puts "VPC per /16: #{c[:vpc_per_slash_16]}"
    calc_vpcs()
  end

end


class BNZOps::Strategy::Network

  DEFAULTS = {
    :large_slash_12 => { :net_cidr => 12, :count => 16, :vpc_cidr => 16 },
    :large_slash_13 => { :net_cidr => 13, :count => 8, :vpc_cidr => 16 },
    :medium_slash_13 => { :net_cidr => 13, :count => 16, :vpc_cidr => 17 },
    :medium_slash_14 => { :net_cidr => 14, :count => 8, :vpc_cidr => 17 },
    :small_slash_14 => { :net_cidr => 14, :count => 16, :vpc_cidr => 18 },
    :small_slash_15 => { :net_cidr => 15, :count => 8, :vpc_cidr => 18 },
    :very_small_slash_15 => { :net_cidr => 15, :count => 16, :vpc_cidr => 19 },
    :very_small_slash_16 => { :net_cidr => 16, :count => 8, :vpc_cidr => 19 }
  }

  CONVENTIONS = {
    :naming_conventions => {
      :blue_green_8 => [ :prod0, :prod1, :stg0, :stg1, :shared, :test, :dev, :lab ],
      :blue_green_16 => [ :prod0, :prod1, :stg0, :stg1, :unallocated_prod_network, :unallocated_prod_network, :unallocated_prod_network, :shared, :uat, :qa, :dev, :unallocated_non_prod_network, :unallocated_non_prod_network, :unallocated_non_prod_network, :unallocated_non_prod_network, :lab ],
      :full_layout_8 => [ :prod, :dr, :stg, :shared, :uat, :qa, :dev, :lab ],
      :full_layout_16 => [ :prod, :dr, :stg, :unallocated_prod_network, :unallocated_prod_network, :unallocated_prod_network, :unallocated_prod_network, :shared, :uat, :qa, :dev, :unallocated_non_prod_network, :unallocated_non_prod_network, :unallocated_non_prod_network, :unallocated_non_prod_network, :lab ]
    }
  }


  SUBNET_LENGTH = 256

  BNZOps::Strategy.register(self)
  include BNZOps::Questionnaire

  def initialize()
    @networks = []
    questionnaire_setup()
  end

  def process()
    determine_network()
    determine_vpcs()
    load_network()
    save_network()
  end

  def load_content()
    require_relative 'network_questionnaire'
    content = QUESTIONNAIRE
  end

  def save_network()
    puts @network.inspect
    filename = @cli.ask("Network filename?  ") {|a| a.default = "./network.yml"}
    puts "Saving network to: #{filename}"
    f = File.open(filename, 'w')
    begin
      f.write(@network.to_yaml)
      f.close
      puts "Network saved to #{filename}"
    rescue StandardError => e
      puts "Error writing #{filename}: #{e.inspect}"
    end
  end

  def load_network()
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

  def calc_vpc_per_slash_16()
    c = @config
    case c[:net_cidr]
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
  end

  def calc_vpcs()
    c = @config
    #case c[:net_cidr]
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

  def determine_network()
    c = @config
    c[:net_cidr] = DEFAULTS[c[:network_cidr]][:net_cidr]
    c[:count] = DEFAULTS[c[:network_cidr]][:count]
    c[:vpc_cidr] = DEFAULTS[c[:network_cidr]][:vpcc_cidr]
    c[:network] = "#{c[:private_network]}.#{c[:octet_start]}.0.0/#{c[:net_cidr]}"
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


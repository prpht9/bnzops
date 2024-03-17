require 'highline'
require 'yaml'
require_relative '../../../config/defaults.rb'
require_relative '../../../config/network_questionnaire.rb'

class BNZOps::Action::ConfigureNetwork

  SUBNET_LENGTH = 256
  #CONFIG_ARRAYS = [:naming_conventions]
  CONFIG_ARRAYS = []
  SUBNET_NETMASK_HASH = {
    12 => {
      8 => 15,
      16 => 16
    },
    13 => {
      8 => 16,
      16 => 17
    },
    14 => {
      8 => 17,
      16 => 18
    },
    15 => {
      8 => 18,
      16 => 19
    },
    16 => {
      8 => 19,
      16 => 20
    }
  }
  
  @@contrib_path = ENV['CONTRIB_PATH'] ||= '../../../contrib/'

  def initialize(*args, **conf)
    # these are the standard Highline.new options
    # https://www.rubydoc.info/github/JEG2/highline/master/HighLine
    #@highline_opts = []
    #if conf.key?(:highline)
    #  @highline_opts << conf[:highline][:input] ||= $stdin
    #  @highline_opts << conf[:highline][:output] ||= $stdout
    #end
    # end standard Highline options

    #@cli = HighLine.new(@highline_opts)
    @cli = HighLine.new
    @config = {}
    @defaults = DEFAULTS
    @networks = []
    @questionnaire = NETWORK_QUESTIONNAIRE
  end

  def start()
    #load_contrib_packages
    walk_questionnaire
    show_results
    build_configuration
    show_networks
  end

  def load_contrib_packages()
    packages = []
    contrib_path = File.join(File.dirname(__FILE__), @@contrib_path )
    puts "Contrib Path: #{contrib_path}"
    contrib_package_paths = Dir.children(contrib_path)
    contrib_package_paths.each do |d|
      package = d
      if [ File.directory?(File.join(contrib_path, d)) ]
        puts "Loading Contrib Package: #{d}"
      else
        puts "#{d} is not a directory. Skipping."
        next
      end
      package_path = File.join(contrib_path, d)
      puts "Package Path: #{package_path}"
      packages << package
      package_config_path = File.join(package_path, 'config')
      puts "Package Config Path: #{package_config_path}"
      package_configs = Dir.children(package_config_path)
      package_configs.each do |c|
        if [ File.file?(File.join(package_config_path, c)) ]
          puts "Loading Contrib Package Config: #{c}"
        else
          puts "#{c} is not a file. Skipping."
          next
        end
        package_config = File.join(package_config_path, c)
        require package_config 
      end
      join_contrib_config(package)
    end
    puts "Defaults: #{@defaults}"
  end

  def join_contrib_config(p)
    contrib_config = eval("BNZOps::Contrib::Packages::#{p.upcase}")
    contrib_config.keys.each do |k|
      if [ CONFIG_ARRAYS.include?(k) ]
        contrib_config[k].each do |x|
          @defaults[k] << x
        end
      else
        @defaults[k].merge!(contrib_config[k])
      end
    end
  end

  def walk_questionnaire()
    @questionnaire.each do |entry|
      q_key, q = entry
      next if _skip?(entry)
      @cli.say q[:description]
      answer = @cli.ask("#{q[:question]}  ", Integer) {|a| a.in = q[:validation] }
      if q[:answer_type] == :literal
        @config[q_key] = answer
      else
        @config[q_key] = q[:answers][answer - 1]
      end
    end
  end

  def show_results()
    puts @config.inspect
    filename = @cli.ask("Configuration filename?  ") {|a| a.default = "./network_strategy.yml"}
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

  def build_configuration()
    determine_network()
    map_network()
  end

  def show_networks()
    puts @config.inspect
    filename = @cli.ask("Networks filename?  ") {|a| a.default = "./network.yml"}
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

  def determine_network()
    c = @config
    c[:net_info] = @defaults[c[:network_type]]
    c[:count] = @defaults[c[:network_type]][:count]
    c[:net_size] = @defaults[c[:network_type]][:net_size]
    c[:vpc_size] = @defaults[c[:network_type]][:vpc_size]
    c[:network] = BNZOps::Network.new("#{c[:private_network]}.#{c[:octet_start]}.0.0/#{c[:net_size]}")
    c[:network].subnet_netmask = SUBNET_NETMASK_HASH[c[:net_size]][c[:count]]
    tld = BNZOps::Network.new(c[:network].cidr)
    tld.subnet_netmask = tld.netmask + 1
    c[:tld] = tld.cidr
    c[:subdomains] = []
    c[:segments] = []
    tld.subnets.each do |sd_cidr|
       sd = BNZOps::Network.new(sd_cidr)
       sd.subnet_netmask = sd.netmask + 1
       c[:subdomains] << sd.cidr
       sd.subnets.each do |seg_cidr|
         seg = BNZOps::Network.new(seg_cidr)
         seg.subnet_netmask = seg.netmask + 1
         c[:segments] << seg.cidr
       end
    end
    c[:environments] = c[:network].subnets
    puts "Network: #{c[:network]}"
  end

  def map_network()
    c = @config
    c[:networks] = {
      subdomains: {},
      segments: {},
      spokes: {},
      hub: {}
    }
    nets = c[:networks]
    names = @defaults[:naming_conventions][:blue_green_8][:names]
    nets["tld"] = c[:tld]
    pseg, dseg = c[:segments].each_slice(2).to_a
    seg_a = [
      [:subdomains, c[:subdomains]],
      [:prod_seg, pseg],
      [:dev_seg, dseg]
    ]
    seg_a.each do |a|
      _assign_seg_values(c, nets, names, a[0], a[1])
    end
    penv, senv, tenv, denv = c[:environments].each_slice(2).to_a
    env_a = [
      [:prod_envs, penv],
      [:shared_envs, senv],
      [:test_envs, tenv],
      [:dev_envs, denv]
    ]
    env_a.each do |a|
      _assign_env_values(c, nets, names, a[0], a[1])
    end
  end

  private

  def _assign_seg_values(c, nets, names, subj, obj)
    (0..1).to_a.each do |i|
      nets[:segments][names[subj][i]] = obj[i]
    end
  end

  def _assign_env_values(c, nets, names, subj, obj)
    hub = @defaults[:naming_conventions][:blue_green_8][:hub]
    (0..1).to_a.each do |i|
      peers = []
      role = ''
      grp = ''
      if names[subj][i] == "unallocated"
        next
      elsif names[subj][i] == hub
        peers.concat(@defaults[:naming_conventions][:blue_green_8][:spokes])
        role = "hub"
        grp = :hub
      else
        peers.concat([hub])
        role = "spoke"
        grp = :spokes
      end
      n = names[subj][i]
      nets[grp][n] = {
        network: n,
        cidr: obj[i],
        network_role: role,
        peers: peers
      }
    end
  end

  def _skip?(entry)
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


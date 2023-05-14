require 'highline'
require 'yaml'
require_relative '../../../config/defaults.rb'
require_relative '../../../config/group_questionnaire.rb'

class BNZOps::Action::ConfigureGroups < BNZOps::Action::Questionnaire

  CONFIG_ARRAYS = [:naming_conventions]

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
    @questionnaire = GROUP_QUESTIONNAIRE
  end

  def start()
    load_contrib_packages
    walk_questionnaire
    show_results
    build_configuration
    show_groups
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

  def show_results()
    puts @config.inspect
    filename = @cli.ask("Configuration filename?  ") {|a| a.default = "./group_strategy.yml"}
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

  def show_groups()
    puts @config.inspect
    filename = @cli.ask("Group filename?  ") {|a| a.default = "./group.yml"}
    puts "Saving groups to: #{filename}"
    f = File.open(filename, 'w')
    begin
      f.write(@config.to_yaml)
      f.close
      puts "Groups saved to #{filename}"
    rescue StandardError => e
      puts "Error writing #{filename}: #{e.inspect}"
    end
  end

  def build_configuration()
    determine_groups()
  end

  def determine_groups()
    c = @config
    #c[:net_size] = @defaults[c[:network_size]][:net_size]
    #c[:count] = @defaults[c[:network_size]][:count]
    #c[:vpc_size] = @defaults[c[:network_size]][:vpcc_size]
    #c[:network] = "#{c[:private_network]}.#{c[:octet_start]}.0.0/#{c[:net_size]}"
    #c[:octet1] = c[:private_network].to_i
    #c[:octet2] = c[:octet_start].to_i
    #c[:octet3] = 0
    #c[:octet4] = 0
    puts "Groups: #{c}"
  end

end


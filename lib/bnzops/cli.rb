require 'optparse'

class BNZOps::CLI

  def initialize(*args, **conf)
    @conf = conf ||= {}
  end
    
  def start(args)

    options = {}
    parser = nil 
    OptionParser.new do |opts|
      opts.banner = 
"Usage: binzops [options] [action]

  Actions:
    configure_network
    configure_groups

"
    
      opts.on("--debug", "Enable Ruby Debug") do
        options[:debug] = true
      end
      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end
      opts.on("-h", "--help", "Show Help") do
        puts opts
        exit
      end
      parser = opts
    end.parse!(args)

    $BNZ_DEBUG = true if options[:debug]
    
    #p options if $DEBUG
    p args if $BNZ_DEBUG
    
    action = args.shift
    
    case action
    when /configure_network/
      b = BNZOps::Action::ConfigureNetwork.new(@conf)
      b.start
    when /configure_groups/
      b = BNZOps::Action::ConfigureGroups.new(@conf)
      b.start
    when /help/
    when /help/
      puts parser
    else
      puts parser
    end
  end

end

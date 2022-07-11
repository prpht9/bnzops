#!/usr/bin/env ruby

require 'optparse'
require 'uri'

module BNZOps
  class CLI

    def self.execute(stdout, arguments=[])

      # NOTE: the option -p/--path= is given as an example, and should be replaced in your application.

      options = {
        :path     => '/',
        :pattern  => /.*/
      }
      mandatory_options = %w(  )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          Bias Near Zero Ops (bnzops) command line utility

          Usage: bnzops [action] [options]

             Actions:         Description:
             --------         ------------
             configure        Configure a new set of configuration files

          Options are:
        BANNER
        opts.separator ""
        opts.on("-D", "--debug",
                "Enables $DBG in Ruby.",
                "Default: false") { options[:debug] = true }
        opts.on("-P", "--pattern 'PATTERN'", String,
                "A ruby pattern to filter results.",
                "Example: '/^New Text Document.*$/'",
                "Default: '.*'") { |arg| options[:pattern] = eval(arg) }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      $DBG = true if options[:debug]

      puts "CLI ARGV Length: #{arguments.length}" if $DBG == true
      puts "CLI ARGV: #{arguments.inspect}" if $DBG == true


      puts "Options: #{options.inspect}" if $DBG == true

      args = ARGV.dup
      puts parser.parse("--help") if args.length == 0
      action = args.shift



      case action
      when /configure/
        BNZOps::Strategy.walk_registry
        #q.walk_questionnaire
        #q.show_results
      else
        usage(parser)
      end

    end

    def self.usage(parser)
      puts parser.parse("--help")
      exit
    end

  end

end

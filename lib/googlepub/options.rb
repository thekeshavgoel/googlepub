require 'optparse'

require "#{File.dirname(__FILE__)}/auth.rb"
require File.expand_path(File.dirname(__FILE__) + '/../googlepub')


module Googlepub

  class Options

    BANNER = <<-EOS
Googlepub it gem for Google Android Publisheing API.
Abilities:
1) Store Listing
2) APK - All tracks
3) In-App Purchases (Managed and Subscriptions) (Coming Soon)

Usage:
  googlepub COMMAND [OPTIONS]
  Main commands:
    apk. metadata
Example:
  googlepub metadata -l "en-US" -p "com.keshav.goel" --store -t "Title" -s "Short Description" -f "fullDescription" --icon "icon.png"
  googlepub apk -p "com.keshav.goel" --file "file.apk" --track "beta"
Dependencies:
  Ruby, HTTP

Author: @thekeshavgoel
Email: keshu_gl@yahoo.com
    EOS

    # Creating a CommandLine runs off of the contents of ARGV.
    def initialize
      parse_options
      cmd = ARGV.shift
      @command = cmd && cmd.to_sym
      @auth = Googlepub::Auth.new(@options)
      run
      @auth.validate
      @auth.commit
    end

    def run
      begin
        case @command
        when :apk   then puts Googlepub.call_apk(@options)
        when :metadata  then puts Googlepub.call_metadata(@options)
        else
          puts "Please provide command to Excute - 'apk' or 'metadata'"
          exit (1)
        end
      end
    end

    # Print out the usage help message.
    def usage
      puts "\n#{@option_parser}\n"
      exit
    end


    private
    def parse_options
      @options = {"language" => "en-US"}
      @option_parser = OptionParser.new do |opts|
        opts.on('-k', '--key [KEY]', "Key for the Account from Google Developer Console (ENV['KEY'])") do |l|
          @options["language"] = l
        end
        opts.on('-i', '--iss [ISSUER]', "ISS for the Account from Google Developer Console (ENV['ISS'])") do |l|
          @options["language"] = l
        end
        opts.on('-p', '--package [PACKAGE]', "Package to update on the Google Developer Console (ENV['PACKAGE'])") do |pa|
          @options["package"] = pa
        end
        opts.on('--store', 'Specify that Store Listing details are to be Updated.') do |s|
          @options["store"] = s
        end
        opts.on('-t', '--title [TITLE]', 'Name for your App') do |k|
          @options["title"] = k
        end
        opts.on('-f', '--full  [FULLDESCRIPTION]', 'Full Description for your App') do |t|
          @options["fullDescription"] = t
        end
        opts.on('-s', '--short [SHORTDESCRIPTION]', 'Short Description for your App') do |d|
          @options["shortDescription"] = d
        end
        opts.on('-v', '--video [VIDEO]', 'Youtube Video URL') do |o|
          @options["video"] = o
        end
        opts.on('--details', 'Specify that the details are to be updated (Website, Email and Phone)') do |c|
          @options["details"] = true
        end
        opts.on('-w', '--website [WEBSITE]', 'Website for Contact') do |l|
          @options["website"] = l
        end
        opts.on('-e', '--email [EMAIL]', 'Email for Contact') do |n|
          @options["email"] = n
        end
        opts.on('--phone [PHONE]', 'Phone for Contact') do |r|
          @options["phone"] = r
        end
        opts.on('--screenshots', 'Specify that Screenshots are to be updated for Contact') do |r|
          @options["screenshots"] = r
        end
        opts.on('--featureGraphic [FEATUREGRAPHIC]', 'featureGraphic for your App eg: "path/to/file"') do |r|
          @options["featureGraphic"] = r
        end
        opts.on('--icon [ICON]', 'icon for your App eg: "path/to/file"') do |z|
          @options["icon"] = z
        end
        opts.on('--phoneScreenshots [PHONE SCREENSHOTS]', 'phoneScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."') do |r|
          @options["phoneScreenshots"] = r
        end
        opts.on('--promoGraphic [PROMOGRAPHIC]', 'promoGraphic for your App eg: "path/to/file"') do |r|
          @options["promoGraphic"] = r
        end
        opts.on('--sevenInchScreenshots [SEVENINCHSCREENS]', 'sevenInchScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."') do |r|
          @options["sevenInchScreenshots"] = r
        end
        opts.on('--tenInchScreenshots [TENINCHSCREENS]', 'tenInchScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."') do |r|
          @options["tenInchScreenshots"] = r
        end
        opts.on('--tvBanner [TVBANNER]', 'tvBanner for your App (comma separated) eg: "path/to/file1,path/to/file1,.."') do |r|
          @options["tvBanner"] = r
        end
        opts.on('--tvScreenshots [TVSCREENS]', 'tvScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."') do |r|
          @options["tvScreenshots"] = r
        end
        opts.on('--wearScreenshots [WEARSCREENS]', 'wearScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."') do |r|
          @options["wearScreenshots"] = r
        end
        opts.on('--file [FILE]', 'APK file to upload eg: "path/to/file"') do |r|
          @options["file"] = r
        end
        opts.on('--track [TRACK]', ' Track to which APK file is to be uploaded eg: "beta"') do |r|
          @options["file"] = r
        end
        opts.on_tail('-v', '--version', 'display googlepub version') do
          puts "Googlepub version #{Googlepub::VERSION}"
          exit
        end
        opts.on_tail('-h', '--help', 'display this help message') do
          usage
        end
      end
      @option_parser.banner = BANNER
      begin
        @option_parser.parse!(ARGV)
      rescue OptionParser::InvalidOption => e
        puts e.message
        exit(1)
      end
    end

  end

end

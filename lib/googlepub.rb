require File.expand_path(File.dirname(__FILE__) + '/googlepub/metadata.rb')
require File.expand_path(File.dirname(__FILE__) + '/googlepub/apk.rb')

module Googlepub

  ROOT = File.expand_path(File.dirname(__FILE__) + '/..')

  VERSION = "0.0.2"

  def self.call_metadata(options = {})
    @pack = Googlepub::Metadata.new(options["language"])
    if options["store"]
      p "Going to edit Store Listing"
      @pack.edit_listings(options["title"], options["fullDescription"], options["shortDescription"], options["video"])
    end
    if options["icon"]
      p "Going to Upload Icon on GooglePlay Store:"
      @pack.imagefile("icon", options["icon"])
    end

    if options["details"]
      p "Going to edit Details"
      @pack.edit_details(options["website"], options["email"], options["phone"])
    end

    if options["screenshots"]
      p "Going to Update Screenshots"
      types = ["featureGraphic", "phoneScreenshots", "promoGraphic", "sevenInchScreenshots", "tenInchScreenshots", "tvBanner", "tvScreenshots", "wearScreenshots"]
      types.each do |t|
        if options[t]
          screens = options[t].split(",")
          screens.each do |sc|
            @pack.imagefile(t, sc)
          end
        end
      end
    end

  end

  def self.call_apk(options = {})
    if !options["file"]
      p "Please provide the file to input: "
      @file = gets.chomp
      if !@file
        p "No APK file provided".red
      end
    else
      @file = options["file"]
    end

    if !options["track"]
      p "Please provide the Track for the APK [alpha, beta, prod] (for ease use --track)"
      @track = gets.chomp
      if !@track
        p "No track provided".red
      end
    else
      @track = options["track"]
    end

    if !options["version"]
      p "Please provide the Version (Code) for the APK"
      @version = gets.chomp
    else
      @version = options["version"]
    end
    if !@version
      p "Invalid request, Please provide a Version!".red
      exit (1)
    end
    @apk = Googlepub::APK.new(@file, @track)
    @apk.upload_apk
    @apk.select_version(@version)

  end

end

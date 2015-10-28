require 'httparty'
require 'httmultiparty'
require 'colorize'

module Googlepub

  class Inapps
    def initialize(sku, language)
      @sku = sku
      @language = language
      @package = ENV['PACKAGE']
      @access_token = ENV['ACCESS_TOKEN']
      if !@access_token || !@package
        p "Invalid call".red
        exit 1
      end
    end

    def find_inapp
      @inapp = HTTParty.get("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/inappproducts/#{@sku}?access_token=#{@access_token}").parsed_response
      if !@inapp || !@inapp["listings"][@language]["title"]
        puts "In-app: #{@sku} Not Found!".red
        exit 1
      else
        puts "In-App: #{@sku} found, Name:#{@inapp["listings"][@language]["title"]}, Price: #{@inapp["defaultPrice"]["priceMicros"]}".green
      end
    end

    def edit_inapp(options = {})
      p "Going to Edit the In-App"
      new_iap = {"packageName"=>@package, "sku"=>@sku, "status"=>options["status"] || @inapp["status"], "purchaseType"=>@inapp["purchaseType"],
   		"defaultPrice"=>{"priceMicros"=>options["price"] || @inapp["defaultPrice"]["priceMicros"], "currency"=>options["currency"] || @inapp["defaultPrice"]["currency"]}, "listings"=>{@language=>{"title"=>options["title"] || @inapp["listings"][@language]["title"],
   		"description"=>options["fullDescription"] || @inapp["listings"][@language]["description"] }}, "defaultLanguage"=>@language}

  		resp = HTTParty.put("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/inappproducts/#{@sku}?autoConvertMissingPrices=true&access_token=#{@access_token}", :headers => { 'Content-Type' => 'application/json' },
  	  		:body => new_iap.to_json).parsed_response
      if options["title"] && resp["listings"][@language]["title"] != options["title"]
        puts "Unable to Change name, Response -> #{resp}".red
        exit 3
      elsif options["title"] && resp["listings"][@language]["title"] == options["title"]
        puts "Done: Name Change".green
      end

  		if options["price"] && resp["defaultPrice"]["priceMicros"] != options["price"]
  			puts "Unable to change price, Response -> #{resp}".red
  			exit 3
  		elsif options["price"] && resp["defaultPrice"]["priceMicros"] == options["price"]
  		  puts "Done: Price Change".green
      end

  	end

  end

end

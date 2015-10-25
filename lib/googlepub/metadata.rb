require "base64"
require 'jwt'
require 'jwt/json'
require 'httparty'
require 'httmultiparty'
require 'colorize'

module Googlepub

  class Metadata

    def initialize(language)
      @language = language
      @edit_id = ENV['EDIT_ID']
      @access_token = ENV['ACCESS_TOKEN']
      @package = ENV['PACKAGE']
      if !@edit_id || !@access_token || !@package
        p "Missing Something, Invalid call".red
      end
      get_listing
      get_details
    end

    def get_listing
      @listing = HTTParty.get("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/listings/#{@language}?access_token=#{@access_token}", :body =>{}).parsed_response
      if @listing["language"] != @language
        puts "Unable to find Listing"
        exit
      end
    end

    def get_details
      @details = HTTParty.get("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/details?access_token=#{@access_token}", :body =>{}).parsed_response
    end

    def edit_listings (title, fullDescription, shortDescription, video)
      app_listing = {
      "language"=> @language,
      "title"=> title || @listing["title"],
      "fullDescription"=> fullDescription || @listing["fullDescription"],
      "shortDescription"=> shortDescription || @listing["shortDescription"],
      "video"=> video || @listing["video"]
      }
      listings = HTTParty.put("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/listings/#{@language}?access_token=#{@access_token}", :headers => { 'Content-Type' => 'application/json' }, :body =>app_listing.to_json).parsed_response

      if listings["language"] == @language && listings["title"] == title
        puts "Done Listing"
      else
        puts "Error in Listings"
        exit
      end
    end

    def edit_details (website, email, phone)
      details = {
        "defaultLanguage"=> @language,
        "contactWebsite" => website || @details["contactWebsite"],
        "contactEmail" => email || @details["contactEmail"],
        "contactPhone" => phone || @details["contactPhone"]
      }

      details_resp = HTTParty.put("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/details?access_token=#{@access_token}", :headers => { 'Content-Type' => 'application/json' }, :body =>details.to_json).parsed_response
      if details_resp["defaultLanguage"] == @language
        puts "Details entered"
      else
        puts "Error in Details"
        puts details_resp
        exit
      end
    end

    def imagefile(typefile, filename)
      @types = ["featureGraphic","icon", "phoneScreenshots", "promoGraphic", "sevenInchScreenshots", "tenInchScreenshots", "tvBanner", "tvScreenshots", "wearScreenshots"]
      if !@types.include?(typefile)
        puts "Please provide a type out of: #{@types}"
        exit (1)
      end
      file = File.new(filename)
      if !file
        puts "File read error, Maybe file Not found."
        exit (1)
      end
      puts "Uploading #{typefile}"
      resp = HTTMultiParty.post("https://www.googleapis.com/upload/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/listings/#{@language}/#{typefile}?access_token=#{@access_token}",
         :body =>{:somepngfile => file}, :detect_mime_type => true).parsed_response
      if !resp["image"]
        puts "Error Uploading #{typefile}:  #{resp}"
        exit
      else
        puts "Done Uploading #{@language}-#{typefile}"
      end
    end

  end
end

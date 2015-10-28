require 'httparty'
require 'httmultiparty'
require 'colorize'

module Googlepub

  class APK

    def initialize(file, track)
      @track = track
      @file = file
      @edit_id = ENV['EDIT_ID']
      @access_token = ENV['ACCESS_TOKEN']
      @package = ENV['PACKAGE']
      if !@edit_id || !@access_token || !@package
        p "Invalid call".red
      end
      if !File.new(@file)
        p "File read error, Maybe file not found at #{@file}"
        exit (1)
      end
    end

    def list_apks
      apks = HTTParty.get("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/apks?access_token=#{@access_token}")
    end

    def upload_apk
      puts "Uploading the APK".green
      resp = HTTMultiParty.post("https://www.googleapis.com/upload/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/apks?access_token=#{@access_token}",
    	   :body =>{:somefile => File.new(@file)})
      p "Uploaded the APK file".green
    end

    def select_version(version)
      @version = version
      if !@version
        p "Please provide a version with call!".red
        exit (1)
      end
      track_resp = HTTParty.get("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/tracks/#{@track}?access_token=#{@access_token}").parsed_response
      if (track_resp["versionCodes"][0]).to_i >= @version.to_i
      	puts "Please bump the Version. \nAPK with Version: #{@version} already exists!".red
      	exit 0
      end

      track_resp["versionCodes"][0] = @version
      response_track = HTTParty.put("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}/tracks/#{@track}?access_token=#{@access_token}", :headers => { 'Content-Type' => 'application/json' }, :body => track_resp.to_json).parsed_response
      if (response_track["versionCodes"][0]).to_i != @version.to_i
        puts "Unsuccessfull upload, Please check!".red
      else
        puts "Successfully put the #{@version} build to #{@track}".green
      end
    end


  end

end

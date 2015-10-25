require "base64"
require 'jwt'
require 'jwt/json'
require 'httparty'
require 'getoptlong'
require 'httmultiparty'
require 'yaml'
require 'openssl'
require 'colorize'

module Googlepub

  class Auth

    def initialize(options = {})
      if !options["key"] && !ENV['KEY']
        puts "Please provide the key for the Account on Google Developer Console (use option -k or --key for ease): "
        key = gets.chomp
        key = eval %Q{#{key}}
      else
        key = options["key"] || ENV['KEY']
      end
      if !options["iss"] && !ENV['ISS']
        puts "Please provide the ISS for the account on Google Developer Console (use -i or -iss for ease): "
        iss = gets.chomp
        iss = eval %Q{#{iss}}
      else
        iss  = options["iss"] || ENV['ISS']
      end
      if !options["package"] && !ENV['PACKAGE']
        puts "Please provide the package you want to EDIT on (Use option -p or --package for ease): "
        package = gets.chomp
        package = eval %Q{#{package}}
      else
        package = options["package"] || ENV['PACKAGE']
      end
      if (!key || !iss || !package)
        puts "Invalid Arguments!".red
      end
      @key = key
      @iss = iss
      @package = package
      ENV['KEY'] = key
      ENV['ISS'] = iss
      ENV['PACKAGE'] = package
      header = {"alg" => "RS256","typ" => "JWT"}
      claim_set = {
        "iss"=>@iss,
        "scope"=> 'https://www.googleapis.com/auth/androidpublisher',
        "aud"=>"https://www.googleapis.com/oauth2/v3/token",
        "exp" => Time.now.to_i +  3600,
        "iat" => Time.now.to_i
      }
      private_key = @key.to_s
      @key = OpenSSL::PKey.read(private_key)
      if !@key
        puts "Invlaid OPENSLL Key, please check!".red
        exit 1
      end
      jwt = JWT.encode(claim_set, @key, "RS256", header)
      if !jwt
        puts "Invlaid JWT, please check!".red
        exit 1
      end
      data = {"grant_type" => "urn:ietf:params:oauth:grant-type:jwt-bearer", "assertion" => "#{jwt}"}
      response = HTTParty.post("https://www.googleapis.com/oauth2/v3/token", :body => data)
      if !response.parsed_response["access_token"]
        puts "Invlaid or Not generated Access Token, please try again!".red
        puts response.parsed_response
        exit 1
      end
      access_token = response.parsed_response["access_token"] #Access Token valid for 60 minutes
      ENV['ACCESS_TOKEN'] = access_token
      @access_token = access_token
      puts "Access Token: #{access_token}".green
      if @package
        self.edit()
      end
    end

    ################# A new EDIT ##########################
    def edit
      puts "Generating Edit for package: #{@package}"
      headers = {"Authorization" => "Bearer #{@access_token}"}

      edit_response = HTTParty.post("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits", :headers => headers, :body => {}).parsed_response

      if !edit_response["id"]
        puts "Invlaid Edit, No id returned, please check!".red
        p edit_response
        exit 1
      end
      ENV['EDIT_ID'] = edit_response["id"]
      @edit_id = edit_response["id"]
      puts "Edit ID generated: #{ENV['EDIT_ID']}".green
    end

    ##################### Validate Edit ##########################
    def validate
      response_validate = HTTParty.post("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}:validate?access_token=#{@access_token}", :body =>{}).parsed_response
      if response_validate["id"] == @edit_id
        puts "Validated: Good to Go".green
      else
        puts "Invalid Edit, please check!".red
        puts response_validate
        exit 1
      end
    end

      ###################### Commit the Edit ##########################
    def commit
      response_commit = HTTParty.post("https://www.googleapis.com/androidpublisher/v2/applications/#{@package}/edits/#{@edit_id}:commit?access_token=#{@access_token}", :body =>{}).parsed_response
      if response_commit["id"] == @edit_id
        puts "Committed!".green
      else
        puts "Commit Error! please check!".red
        puts response_commit
        exit 1
      end
    end

  end

end

# googlepub

#### The gem to automate everything for GooglePlay Developer Console with a Single Command i.e. googlepub
Store Listing, APK, In-App Purchases, this does it all. This gem uses the Google Publishing API.
Have issues/problems/Feature requests/advices Please add them as Issues. I'll get back to you ASAP.

## Set up Googlepub
In your terminal:
    `[sudo] gem install googlepub`

For updates:
    `[sudo] gem update googlepub`

**This gem is OS independent.**

## Google Play Access

To enable googlepub to access Google Play you have to follow these steps:

* Open the Google Play Console
* Open Settings => API-Access
* Create a new Service Account - follow the link of the dialog
* Create new Client ID
* Select Service Account
* Click Generate new P12 key and store the downloaded file
* The Email address underneath Service account is the email address you have to enter as the Issuer
* Back on the Google Play developer console, click on Grant Access for the newly added service account
* Choose Release Manager from the dropdown and confirm

## Issuer
Copy the email address which looks like *9083982039lnwdnlwk-23929ojkn@developer.gserviceaccount.com* and
- paste it in a file named "issfile" in the working Directory (Without any quotes around the String) or
- pass it as the -i or --iss option with the command as "[ISS]" or
- paste it when asked for as "[ISS]" or
- set as ENV['ISS']


## Keyfile
Store your p12 file in a secure place, for ease open it in any editor and copy the key and
- store in a file named "keyfile" in the working Directory (Without any quotes around the String) or
- pass as -k or --key option with the command as "[key]" or
- paste it when asked for "[key]" or
- set as ENV['KEY']

## Package
The SKU of you App eg. "com.keshav.goel".
- Pass is as -p or --package option with the command or
- when asked for while execution or
- set as ENV['PACKAGE']

##Main commands
- apk
- metadata
- inapps

## Options

With sub command **metadata**:
    -l, --language [LANGUAGE]        The ISO language code (default: "en-US")
    -k, --key [KEY]                  Key for the Account from Google Developer Console (ENV['KEY'])
    -i, --iss [ISSUER]               ISS for the Account from Google Developer Console (ENV['ISS'])
    -p, --package [PACKAGE]          Package to update on the Google Developer Console (ENV['PACKAGE'])
        --store                      Specify that Store Listing details are to be Updated.
    -t, --title [TITLE]              Name for your App
    -f, --full  [FULLDESCRIPTION]    Full Description for your App/Description for your In-App
    -s, --short [SHORTDESCRIPTION]   Short Description for your App
    -v, --video [VIDEO]              Youtube Video URL
        --details                    Specify that the details are to be updated (Website, Email and Phone)
    -w, --website [WEBSITE]          Website for Contact
    -e, --email [EMAIL]              Email for Contact
        --phone [PHONE]              Phone for Contact
        --screenshots                Specify that Screenshots are to be updated for Contact
        --featureGraphic [PATH]      featureGraphic for your App eg: "path/to/file"
        --icon [PATH]                icon for your App eg: "path/to/file"
        --phoneScreenshots [PATH]    phoneScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."
        --promoGraphic [PATH]        promoGraphic for your App eg: "path/to/file"
        --sevenInch [PATH]           sevenInchScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."
        --tenInch [PATH]             tenInchScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."
        --tvBanner [PATH]            tvBanner for your App (comma separated) eg: "path/to/file1,path/to/file1,.."
        --tv [PATH]                  tvScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."
        --wear [PATH]                wearScreenshots for your App (comma separated) eg: "path/to/file1,path/to/file1,.."
        --version                    Display googlepub version
    -h, --help                       Display this help message


With sub command **apk**:
        --file [FILE]                APK file to upload eg: "path/to/file"
        --track [TRACK]              Track to which APK file is to be uploaded eg: "beta"
        --apkversion [Version]       Code Version of your APK you want to deploy
        -h, --help                   Display this help message

With sub command **inapps**:
        --sku [SKU]                  The SKU of the In-App you wish to edit
    -t, --title [TITLE]              Name for your App
    -f, --full  [FULLDESCRIPTION]    Full Description for your App/Description for your In-App
        --price [PRICE]              Price for the In-App in Decimal(eg: 5.99), Will convert to Millionth by self
        --curr [CURR]                3 letter Currency code, as defined by ISO 4217 for your SKU (USD by default)
        --status [STATUS]            Status for your In-App, "active" or "inactive"
        -h, --help                   Display this help message
        (Note: New In-App support Coming Soon!)

**Note: When using inapps sub-command, access_token file created is not deleted(unlike apk and metadata). The access_token saved in the file is reused for multiple In-App activity(Untill its Expiry or another Edit for APK or Metadata).**

### Examples:
googlepub metadata -l "en-US" -p "com.keshav.goel" --store -t "Title" -s "Short Description" -f "fullDescription" --icon "icon.png"

googlepub apk -p "com.keshav.goel" --file "file.apk" --track "beta"

googlepub inapps -p "com.keshav.goel" --sku "com.keshav.inapp.12" --title "InApp 12" --fullDescription "Description" --price 1990000

##### For any issues/problems please add an Issue to the repo.

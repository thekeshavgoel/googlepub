# googlepub

##### The gem to automate everything for GooglePlay Developer Console with a Single Command i.e. googlepub
This gem uses the Google Publishing API

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
Copy and paste the email address which looks like *9083982039lnwdnlwk-23929ojkn@developer.gserviceaccount.com* and pass it as the -i or --iss option with the command or paste it when asked for or set as ENV['ISS']


## Keyfile
Store your p12 file in a secure place, for ease open it in any editor and copy and pass the key as -k or --key option with the command or paste it when asked for or set as ENV['KEY']

## Package
The SKU of you App eg. "com.keshav.goel". Pass is as -p or --package option with the command or when asked for or set as ENV['PACKAGE']

##Main commands
apk
metadata

## Options

### With sub command metadata:
    -k, --key [KEY]                  Key for the Account from Google Developer Console (ENV['KEY'])
    -i, --iss [KEY]                  ISS for the Account from Google Developer Console (ENV['ISS'])
    -p, --package [PACKAGE]          Package to update on the Google Developer Console (ENV['PACKAGE'])
        --store                      Specify that Store Listing details are to be Updated.
    -t, --title [TITLE]              Name for your App
    -f, --full  [FULLDESCRIPTION]    Full Description for your App
    -s, --short [SHORTDESCRIPTION]   Short Description for your App
    -v, --video [VIDEO]              Youtube Video URL
        --details                    Specify that the details are to be updated (Website, Email and Phone)
    -w, --website [WEBSITE]          Website for Contact
    -e, --email [EMAIL]              Email for Contact
        --phone [PHONE]              Phone for Contact
        --screenshots                Specify that Screenshots are to be updated for Contact
        --featureGraphic [FEATUREGRAPHIC]
                                     featureGraphic for your App eg: "path/to/file"
        --icon [ICON]                icon for your App eg: "path/to/file"
        --phoneScreenshots [PHONE SCREENSHOTS]
                                     phoneScreenshots for your App (comma separated) eg:                                                                "path/to/file1,path/to/file1,.."
        --promoGraphic [PROMOGRAPHIC]
                                     promoGraphic for your App eg: "path/to/file"
        --sevenInchScreenshots [SEVENINCHSCREENS]
                                     sevenInchScreenshots for your App (comma separated) eg:                                                            "path/to/file1,path/to/file1,.."
        --tenInchScreenshots [TENINCHSCREENS]
                                     tenInchScreenshots for your App (comma separated) eg:                                                               "path/to/file1,path/to/file1,.."
        --tvBanner [TVBANNER]        tvBanner for your App (comma separated) eg: "path/to/file1,path/to/file1,.."
        --tvScreenshots [TVSCREENS]  tvScreenshots for your App (comma separated) eg:                                                                    "path/to/file1,path/to/file1,.."
        --wearScreenshots [WEARSCREENS]
                                     wearScreenshots for your App (comma separated) eg:                                                                  "path/to/file1,path/to/file1,.."
        --version                    display googlepub version
    -h, --help                       display this help message

### With sub command apk:
        --file [FILE]                APK file to upload eg: "path/to/file"
        --track [TRACK]               Track to which APK file is to be uploaded eg: "beta"
        --version                    display googlepub version
    -h, --help                       display this help message

#Example:
googlepub metadata -l "en-US" -p "com.keshav.goel" --store -t "Title" -s "Short Description" -f "fullDescription" --icon "icon.png"

googlepub apk -p "com.keshav.goel" --file "file.apk" --track "beta"

* **If ENV['KEY'] or -k/--key is not passed, the command will ask for key pass it as "-----KEY---"**
* **If ENV['ISS'] or -i/-iss  is not passed, the command will ask for iss pass it as"iss@account.com"**
* **If ENV['PACKAGE'] or -p/--package is not passed, the command will ask for package pass it as "com.keshav.goel"**

### In-App purchase support coming in a few days.

##### For any issues/problems please add an Issue to the repo.

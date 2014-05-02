popHealth-knife-solo
====================

Repository for easily installing popHealth without a Chef-Server.

Getting Started
-----

This repository is designed to allow a user to easily install popHealth on a remote server using knife solo. In order to use this repository, run the following commands.

    # Clone the repository into your directory of choice
    git clone https://github.com/rbclark/popHealth-knife-solo.git
    
    # cd into the directory
    cd popHealth-knife-solo

    # Install knife-solo and berkshelf
    bundle install

    # Bootstrap the node with the popHealth role (This will install chef, copy required cookbooks, and then run the popHealth role)
    bundle exec knife solo bootstrap username@ip-address -r role[popHealth]

Customizing the Install
-----

If you wish to do additional configuration to the popHealth cookbook, the easiest way to do so is by creating a new environment in the environments folder and setting the configuration options from there. An example of one such configuration is located at environments/example.json. All of the available configuration options are listed there, however an explanation of each is given below. If you wish to leave any of the values at their default values, simply do not include them in your overrides. All config options below go in the override_attributes section of your json file and are provided below in the form of "key_name": "default_value".

Once you are finished setting up the environment file you can pass it in by appending -E environmentName to your command, where environmentName is the name of the file which you created in the environments folder, without the file ending.

    # The user which the popHealth code will be placed under.
    "user": "popHealth",

    # The version of ruby which will be installed and used for running rails on the server.
    "ruby_version":  "2.0.0-p353",

    # The version of phusion passenger which will be installed and used.
    "passenger_version": "4.0.35",

    # The git repository from which the popHealth source will be pulled from.
    "git_repository": "https://github.com/pophealth/popHealth.git",

    # The branch from which the code will be pulled from on the specified site.
    "branch": "master",

    # The URL at which the site will be accessed at.
    "servername": "localhost",

    # The mode which rails should run in, either development or production.
    "environment": "production",

    # Enable a cronjob which will run chef-solo hourly to pull the latest code from git.
    "enable_cron": false,

    # The following json block contains elements used to configure the config/popHealth.yml config file.
    "app_config": {
        
        # Should a user be logged out for inactivity?
        "idle_timeout_enabled" : true,
        
        # How long before a user should be logged out for inactivity?
        "idle_timeout" : 300000,

        # Should the have the staff role by default when created?
        "default_user_staff_role" : true,

        # Should the user be approved by default when created.
        "default_user_approved" : true,

        # Should the site display a logout link?
        "logout_enabled" : true,

        # Should the account link be displayed in the header?
        "edit_account_enabled" : true,
        
        # Should new accounts be creatable, and should a user be able to edit their account?
        "allow_user_update" : true,

        # Add a patient management link.
        "patient_management_enabled" : true,

        # The title of the practice.
        "practice_name" : "General Hospital",
        
        "value_sets" : {
          "ticket_url" : "https://vsac.nlm.nih.gov/vsac/ws/Ticket",
          "api_url" : "https://vsac.nlm.nih.gov/vsac/ws/RetrieveValueSet"
        }
    }

Setting the Proxy
-----

If you are trying to push to a corporate environment which requires a proxy, then there are two ways to set this.

#### 1. Setting the proxy for a remote box with the same proxy as your local machine.

If you already use the same proxy on your local box, then all you need to do is set the http_proxy and https_proxy environment variables. Once these are set you will then be able to run the provisioner as normal and it will automatically detect your proxy settings. 

In order to set the environment variables, simply run the two commands below in the terminal before running the knife solo command, with your proxy server instead of the one shown below.

    export http_proxy="http://your-http-proxy.org:80"
    export https_proxy="http://your-https-proxy.org:80"

#### 2. Setting a different proxy for your remote box than your local box.

If you need to set a different proxy for the remote box, just directly edit the .chef/knife.rb file and change the lines below to reflect your proxy settings.

    http_proxy       ENV['http_proxy']
    https_proxy      ENV['https_proxy']

Additional Development Options
-----

If you wish to checkout the recipes to the cookbooks folder and then run remotely from that folder instead of having berkshelf download the dependencies when you run the script, you can do this by following these steps:

    # Download required cookbooks
    # Note that this will fail if the cookbooks directory already exists.
    # In this case you may either delete the directory and regenerate it or just use the current cookbooks.
    bundle exec berks vendor cookbooks/

Then pass the --no-berkshelf flag to the bootstrap command above, like so:

    bundle exec knife solo bootstrap username@ip-address -r role[popHealth] --no-berkshelf

This will force knife to use the cookbooks located in the cookbooks directory instead of downloading them before runtime. This is convenient for times where you would like to test how changes to a specific cookbook will affect the knife-solo run.

Troubleshooting
-----

#### The Chef run is failing to complete successfully.

This recipe has been tested to work on on Ubuntu 12.04, it should work on other versions of Ubuntu, however is most likely not compatible with other distributions.

#### The node is bootstrapping, however Chef is claiming no resources are updated.

Please check to make sure the nodes directory does not already contain a run list for the IP you are provisioning, as knife solo will default to that before taking the run list you specify.

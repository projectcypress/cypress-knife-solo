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

    # Download required cookbooks
    bundle exec berks install -p cookbooks/

    # Bootstrap the node with the popHealth role (This will install chef, copy required cookbooks, and then run the popHealth role)
    bundle exec knife solo bootstrap username@ip-address -r role[popHealth]

Customizing the Install
-----

If you wish to do additional configuration to the popHealth cookbook, the easiest way to do so is by creating a new environment in the environments folder and setting the configuration options from there. An example of one such configuration is located at environments/example.json. All of the available configuration options are listed there, however an explanation of each is given below. If you wish to leave any of the values at their default values, simply do not include them in your overrides. All config options below go in the override_attributes section of your json file and are provided below in the form of "key_name": "default_value".

    # The user which the popHealth code will be placed under.
    "user": "popHealth"

    # The version of ruby which will be installed and used for running rails on the server.
    "ruby_version":  "1.9.3-p484"

    # The version of phusion passenger which will be installed and used.
    "passenger_version": "3.0.18"

    # The git repository from which the popHealth source will be pulled from.
    "git_repository": "https://github.com/popHealth/popHealth.git"

    # The branch from which the code will be pulled from on the specified site.
    "branch": "master"

    # The URL at which the site will be accessed at.
    "servername": "localhost"

    # The mode which rails should run in, either development or production.
    "environment": "production"

    # Enable a cronjob which will run chef-solo hourly to pull the latest code from git.
    "enable_cron": false

Troubleshooting
-----

#### The Chef run is failing to complete successfully.

This recipe has been tested to work on on Ubuntu 12.04, it should work on other versions of Ubuntu, however is most likely not compatible with other distributions.

#### The node is bootstrapping, however Chef is claiming no resources are updated.

Please check to make sure the nodes directory does not already contain a run list for the IP you are provisioning, as knife solo will default to that before taking the run list you specify.

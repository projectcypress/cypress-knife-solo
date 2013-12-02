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

Troubleshooting
-----

#### The Chef run is failing to complete successfully.

This recipe has been tested to work on on Ubuntu 12.04, it should work on other versions of Ubuntu, however is most likely not compatible with other distributions.

#### The node is bootstrapping, however Chef is claiming no resources are updated.

Please check to make sure the nodes directory does not already contain a run list for the IP you are provisioning, as knife solo will default to that before taking the run list you specify.

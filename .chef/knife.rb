cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
http_proxy       ENV['http_proxy']
https_proxy      ENV['https_proxy']
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"

QUESTIONNAIRE = [

  [ :region_strategy, {
    :description => 
' Region Strategies:
1) Separate Prod from Dev + separate regions for DR (Recommended)
  example: 172.16.0.0/12 
  prod network: 172.16.0.0/14
    prod region: 172.16.0.0/16
    dr region: 172.17.0.0/16
    staging region: 172.18.0.0/16
    staging dr region: 172.19.0.0/16
  future region: 172.20.20/14
  future region: 172.24.20/14
  dev network: 172.28.0.0/14
    uat region: 172.28.0.0/16
    qa region: 172.29.0.0/16
    dev region: 172.30.0.0/16
    vendor region: 172.31.0.0/16
2) Single Region 172.16.0.0/16 (Not Recommended)',
    :answers => [ :separate, :single ],
    :answer_type => :default,
    :validation => 1..2,
    :question => "Region Strategy?"
  }],

  [ :network_strategy, {
    :description => 
' Network Strategies:
1) Three Tier Networking (Recommended)
  prod example:
    public tier: 172.16.0.0/18
    app tier: 172.16.64.0/18 + 172.16.128.0/18
    data tier: 172.16.192.0/18
2) One Network 172.16.0.0/16 (Not Recommended)',
    :answers => [ :three_tier, :one_network],
    :answer_type => :default,
    :validation => 1..2,
    :question => "Network Strategy?"
  }],

  [ :routing_strategy, {
    :skip_answer => :internet,
    :skip_trigger => [
      '@config[:network_strategy]', :one_network
    ],
    :description => 
' Routing Strategies:
1) Outbound Gateways (Recommended)
  routing example: public and data can talk to app tier but not each other
    public route: 172.16.64.0/18 + 172.16.128.0/18 + internet gateway + Outbound Gateway
    app route: 172.16.0.0/16 + Outbound Gateway
    data route: 172.16.64.0/18 + 172.16.128.0/18 + Outbound Gateway
2) No Gateways (Advanced)
  routing example: public and data can talk to app tier but not each other, only public can access internet
    public route: 172.16.64.0/18 + 172.16.128.0/18 + internet gateway
    app route: 172.16.0.0/16 + NO INTERNET
    data route: 172.16.64.0/18 + 172.16.128.0/18 + NO INTERNET
3) Internet Gateways (Not Recommended),
  routing example: public and data can talk to app tier but not each other
    public route: 172.16.0.0/16 + internet gateway
    app route: 172.16.0.0/16 + internet gateway
    data route: 172.16.0.0/16 + internet gateway',
    :answers => [ :outbound, :none, :internet],
    :answer_type => :default,
    :validation => 1..3,
    :question => "Routing Strategy?"
  }],

  [ :firewall_strategy, {
    :description => 
' Firewall Strategies:
1) Role Based (Recommended)
  Global OS Specific Rules (Win, linux, etc)
  Network Tier Rules (public, app, data)
  Host Role Rules (k8s worker, mysql db, haproxy, etc)
  Specific Host Group Rules (k8s cluster 1, k8s cluster 2, etc)
2) Mandatory Access (Advanced)
  Firewall rules for every individual resource',
    :answers => [ :role, :mandatory ],
    :answer_type => :default,
    :validation => 1..2,
    :question => "Firewall Strategy?"
  }],

  [ :private_network, {
    :description => 
' Private Network:
1) 172.16.0.0 (Recommended)
2) 10.0.0.0 ',
    :answers => [ 172, 10 ],
    :answer_type => :default,
    :validation => 1..2,
    :question => "Private Network?"
  }],

  [ :network_size, {
    :description => 
' Network Size:
1) Large Network with open network space 255.255.0.0/12 (Recommended)
  65,536 IPs per /16 Network 1,048,576 total 
  16 Networks in total
  7 Networks in use
  9 Networks available for growth
2) Large Network 255.255.0.0/13
  65,536 IPs per /16 Network 524,288 total
  8 Networks in total
  7 Networks in use
  1 Network available for growth
3) Medium Network with open network space 255.255.0.0/13 (Recommended)
  32,768 IPs per /17 Network 524,288 total
  16 Networks in total
  7 Networks in use
  9 Network available for growth
4) Medium Network 255.255.0.0/14
  32,768 IPs per /17 Network 262,144 total
  8 Networks in total
  7 Networks in use
  1 Networks available for growth
5) Small Network with open network space 255.255.0.0/14 (Recommended)
  16,384 IPs per /18 Network 262,144 total
  16 Networks in total
  7 Networks in use
  9 Networks available for growth
6) Small Network 255.255.0.0/15 131,072 total
  16,384 IPs per /18 Network
  8 Networks in total
  7 Networks in use
  1 Networks available for growth
7) Very Small Network with open network space 255.255.0.0/15 (Recommended)
  8,192 IPs per /19 Network 131,072 total
  16 Networks in total
  7 Networks in use
  9 Networks available for growth
8) Very Small Network 255.255.0.0/16
  8,192 IPs per /19 Network 65,536 total
  8 Networks in total
  7 Networks in use
  1 Networks available for growth
  ',
    :answers => [ :large_slash_12, :large_slash_13, :medium_slash_13, :medium_slash_14, :small_slash_14, :small_slash_15, :very_small_slash_15, :very_small_slash_16 ],
    :answer_type => :default,
    :validation => 1..8,
    :question => "Network Size?"
  }],

  [ :octet_start, {
    :description => 
' Network Starting Octet:
16) 172.16.0.0 or 10.16.0.0 (Recommended for any size)
24) 172.24.0.0 or 10.24.0.0 (Recommended for Medium /13)
28) 172.28.0.0 or 10.28.0.0 (Recommended for Small /14)
30) 172.30.0.0 or 10.30.0.0 (Recommended for Very Small /15)
0-254) You better know your networking (Advanced)',
    :validation => 0..254,
    :answer_type => :literal,
    :question => "Private Network?"
  }],

]


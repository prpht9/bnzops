
DEFAULTS = {
  :large_slash_12 => {
    :net_size => 12,
    :count => 16,
    :vpc_size => 16
  },
  :large_slash_13 => {
    :net_size => 13,
    :count => 8,
    :vpc_size => 16
  },
  :medium_slash_13 => {
    :net_size => 13,
    :count => 16,
    :vpc_size => 17
  },
  :medium_slash_14 => {
    :net_size => 14,
    :count => 8,
    :vpc_size => 17
  },
  :small_slash_14 => {
    :net_size => 14,
    :count => 16,
    :vpc_size => 18
  },
  :small_slash_15 => {
    :net_size => 15,
    :count => 8,
    :vpc_size => 18
  },
  :very_small_slash_15 => {
    :net_size => 15,
    :count => 16,
    :vpc_size => 19
  },
  :very_small_slash_16 => {
    :net_size => 16,
    :count => 8,
    :vpc_size => 19
  },
  :naming_conventions => [
    [ :blue_green_8, {
      :name => "Blue Green style with short names and indexes",
      :size => 8,
      :tags => [
        :blue_green,
        :canary,
        :single_digit_index,
        :index_begins_with_0,
        :prod_50_percent,
        :non_prod_50_percent,
        :shared_in_non_prod,
        :lab
      ],
      :names => [
        :prod0,
        :prod1,
        :stg0,
        :stg1,
        :shared,
        :test,
        :dev,
        :lab
      ]
    }],
    [ :blue_green_16, {
      :name => "Blue Green style with short names and indexes",
      :size => 16,
      :tags => [
        :blue_green,
        :canary,
        :single_digit_index,
        :index_begins_with_0,
        :prod_50_percent,
        :non_prod_50_percent,
        :shared_in_prod,
        :unallocated_nets_in_prod,
        :unallocated_nets_in_non_prod,
        :prod_net_acl_zones_1_to_3,
        :non_prod_net_acl_zones_1_to_3,
        :lab
      ],
      :names => [
        :prod0,
        :prod1,
        :stg0,
        :stg1,
        :unallocated_prod_network,
        :unallocated_prod_network,
        :unallocated_prod_network,
        :shared,
        :uat,
        :qa,
        :unallocated_non_prod_network,
        :unallocated_non_prod_network,
        :unallocated_non_prod_network,
        :unallocated_non_prod_network,
        :dev,
        :lab
      ]
    }]
  ]
}


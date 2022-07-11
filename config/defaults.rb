
DEFAULTS = {
  :large_slash_12 => {
    :net_cidr => 12,
    :count => 16,
    :vpc_cidr => 16
  },
  :large_slash_13 => {
    :net_cidr => 13,
    :count => 8,
    :vpc_cidr => 16
  },
  :medium_slash_13 => {
    :net_cidr => 13,
    :count => 16,
    :vpc_cidr => 17
  },
  :medium_slash_14 => {
    :net_cidr => 14,
    :count => 8,
    :vpc_cidr => 17
  },
  :small_slash_14 => {
    :net_cidr => 14,
    :count => 16,
    :vpc_cidr => 18
  },
  :small_slash_15 => {
    :net_cidr => 15,
    :count => 8,
    :vpc_cidr => 18
  },
  :very_small_slash_15 => {
    :net_cidr => 15,
    :count => 16,
    :vpc_cidr => 19
  },
  :very_small_slash_16 => {
    :net_cidr => 16,
    :count => 8,
    :vpc_cidr => 19
  },
  :naming_conventions => {
    :blue_green_8 => [
      :prod0,
      :prod1,
      :stg0,
      :stg1,
      :shared,
      :test,
      :dev,
      :lab
    ],
    :blue_green_16 => [
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
      :dev,
      :unallocated_non_prod_network,
      :unallocated_non_prod_network,
      :unallocated_non_prod_network,
      :unallocated_non_prod_network,
      :lab
    ],
    :full_layout_8 => [
      :prod,
      :dr,
      :stg,
      :shared,
      :uat,
      :qa,
      :dev,
      :lab
    ],
    :full_layout_16 => [
      :prod,
      :dr,
      :stg,
      :unallocated_prod_network,
      :unallocated_prod_network,
      :unallocated_prod_network,
      :unallocated_prod_network,
      :shared,
      :uat,
      :qa,
      :dev,
      :unallocated_non_prod_network,
      :unallocated_non_prod_network,
      :unallocated_non_prod_network,
      :unallocated_non_prod_network,
      :lab
    ]
  }
}


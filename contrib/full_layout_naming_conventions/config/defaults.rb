
BNZOps::Contrib::Packages::FULL_LAYOUT_NAMING_CONVENTIONS = {
  :naming_conventions => {
    :full_layout_8 => {
      :name => "Full Layout style with long names",
      :size => 8,
      :tags => [
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
        :production,
        :dr,
        :shared,
        :hub,
        :staging,
        :qa,
        :dev,
        :lab
      ]
    },
    :full_layout_16 => {
      :name => "Full Layout style with long names",
      :size => 16,
      :tags => [
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
        :production,
        :dr,
        :staging,
        :unallocated_prod_network,
        :unallocated_prod_network,
        :unallocated_prod_network,
        :vpn,
        :shared,
        :perftest,
        :sectest,
        :uat,
        :qa,
        :unallocated_non_prod_network,
        :unallocated_non_prod_network,
        :dev,
        :lab
      ]
    }
  }
}


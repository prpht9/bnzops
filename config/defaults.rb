
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
  :naming_conventions => {
    :blue_green_8 => {
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
      :names => {
        subdomains: [
          "prod-net",
          "dev-net"
        ],
        prod_seg: [
          "prod-seg",
          "shared-seg"
        ],
        dev_seg: [
          "test-seg",
          "dev-seg"
        ],
        prod_envs: [
          "prod",
          "dr"
        ],
        shared_envs: [
          "shared",
          "hub"
        ],
        test_envs: [
          "staging",
          "dev"
        ],
        dev_envs: [
          "unallocated",
          "lab"
        ]
      },
      :spokes => [
        "prod",
        "dr",
        "shared",
        "staging",
        "dev",
        "lab",
      ],
      :hub => "hub"
    },
    :blue_green_16 => {
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
    }
  },
  :group_strategy => {
    :team_small => {
      :name => "Small Team Group Naming Strategy",
      :description => "Keep It Simple Stupid, no frills, just basic groups to drop everyone into.",
      :size => 'small',
      :tags => [
        :team,
        :small,
        :generic_support,
        :single_finance_group,
        :network_in_platform,
        :infrstructure_in_platform,
        :devops_in_platform,
        :executive_in_management,
      ],
      :names => [
        'engineering',
        'platform',
        'product',
        'security',
        'support',
        'management',
        'hr',
        'marketing',
        'sales',
        'finance'
      ]
    },
    :team_medium => {
      :name => "Medium Team Group Naming Strategy",
      :description => "Keep It Simple Stupid, no frills, just basic groups to drop everyone into.",
      :size => 'medium',
      :tags => [
        :team,
        :medium,
        :generic_support,
        :two_finance_group,
        :network_and_dba,
        :qa_in_engineering,
        :infrstructure_in_platform,
        :sre_in_platform,
        :devops_in_platform,
        :executive_and_management,
      ],
      :names => [
        'engineering',
        'platform',
        'dba',
        'network',
        'product',
        'security',
        'support',
        'management',
        'executive',
        'hr',
        'marketing',
        'sales',
        'auditor',
        'finance'
      ]
    },
    :team_large => {
      :name => "Large Team Group Naming Strategy",
      :description => "Keep It Simple Stupid, no frills, just basic groups to drop everyone into.",
      :size => 'large',
      :tags => [
        :team,
        :large,
        :network_and_dba,
        :sre,
        :separated_finance,
        :separated_platform,
        :separated_support,
        :executive_and_management
      ],
      :names => [
        'engineering',
        'platform',
        'dba',
        'sre',
        'network',
        'qa',
        'product',
        'security',
        'csr',
        'tech_support',
        'management',
        'executive',
        'hr',
        'marketing',
        'sales',
        'fin_admin',
        'fin_ar',
        'fin_ap',
        'fin_corp',
        'fin_auditor'
      ]
    },
    :responsibility => {
      :name => "Responsibility Group Naming Strategy",
      :description => "This model can be confusing if you also use action based roles.",
      :size => 'large',
      :tags => [
        :responsibility,
        :large,
        :admin,
        :cloud,
        :user,
        :security
      ],
      :names => [
        "cloud-admin",
        "cloud-developer",
        "cloud-user",
        "cloud-viewer",
        "network-admin",
        "security-admin"
      ]
    },
  },
  :role_strateegy => {
    :action => [
      'compute_admin',
      'compute_user',
      'compute_viewer',
      'k8s_admin',
      'k8s_user',
      'k8s_viewer',
      'data_admin',
      'data_user',
      'data_viewer',
      'log_admin',
      'log_user',
      'log_viewer',
      'iam_admin',
      'iam_user',
      'iam_viewer',
      'vault_admin',
      'vault_user',
      'vault_viewer',
      'storage_admin',
      'storage_user',
      'storage_viewer',
      'network_admin',
      'network_user',
      'network_viewer'
    ],
    :env => [
      'stg_atlassian_admin',
      'stg_k8s_admin',
      'stg_k8s_tools_admin',
      'stg_compute_admin',
      'stg_data_warehouse_admin',
      'stg_data_warehouse_user',
      'perf_admin',
      'perf_developer',
      'perf_gcs_admin',
      'perf_gcs_viewer'
    ]
  }
}


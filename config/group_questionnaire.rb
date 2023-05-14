GROUP_QUESTIONNAIRE = [

  [ :access_control_strategy, {
    :description => 
' Access Control Strategies:
1) Discretionary Access Control: apply roles to groups (Recommended)
  Group: Product
    Roles: warehouse_read, iam_read
    Members: Alice, Bob, Charlie
  Group: Engineering
    Roles: warehouse_write, log_read, system_read, iam_read
    Members: David, Edward, Frank
  Group: Platform
    Roles: warehouse_write, log_write, system_write, network_write, iam_read
    Members: George, Harold, Jack
  Group: Security
    Roles: warehouse_read, log_write, system_write, network_read, iam_write
    Members: Ken, Larry, Mike
2) Discretionary Access Control: apply roles to users (Not Recommended)
  Users: Alice, Bob, Charlie
    Roles: warehouse_read, log_read, iam_read
  Users: David, Edward, Frank
    Roles: warehouse_write, log_write, system_read, iam_read
  Users: George, Harold, Jack
    Roles: warehouse_write, log_write, system_write, network_write, iam_read
  Users: Ken, Larry, Mike
    Roles: warehouse_read, log_read, system_write, network_read, iam_write
3) Mandatory Access Control: direct permission grants to users (Support = Never)',
    :answers => [ :dac_group, :dac_user, :mac ],
    :answer_type => :default,
    :validation => 1..2,
    :question => "Access Control Strategy?"
  }],

  [ :group_strategy, {
    :skip_answer => :none,
    :skip_trigger => [
      '@config[:access_control_strategy]', :dac_user
    ],
    :description => 
' Group Strategies:
1) Small Team (Recommended)
      engineering, platform, product, security, support, management, hr, marketing, sales, finance
2) Medium Team (Recommended)
      engineering, platform, product, security, support, management, hr, marketing, sales, finance
      dba, network, executive, auditor
3) Large Team (Recommended)
      engineering, platform, product, security, csr, management, hr, marketing, sales, fin_admin
      fin_ar, fin_ap, fin_corp, fin_auditor, tech_support, dba, qa, sre, network, executive, 
4) Responsibility Based - (Not Recommended)
  Name Groups after the Responsibility
    cloud-admin, cloud-developer, cloud-user, cloud-viewer, network-admin, security-admin',
    :answers => [ :team_small, :team_medium, :team_large, :responsibility ],
    :answer_type => :default,
    :validation => 1..4,
    :question => "Group Strategy?"
  }],

  [ :role_strategy, {
    :description => 
' Role Strategies:
1) Action Based (Recommended)
  Name Examples:
    compute_admin, k8s_user, data_viewer, iam_admin, storage_user, network_admin
2) Env Based
  Name Examples:
    prod_viewer, staging_admin, staging_user, dev_admin',
    :answers => [ :action, :env ],
    :answer_type => :default,
    :validation => 1..1,
    :question => "Role Strategy?"
  }],

#  [ :security_roles, {
#    :description => 
#' Security Roles:
#1) Basic: (Recommended)
#  Role: sec_admin                     Role: sec_auditor
#    Permissions:                        Permissions:
#      Organization Administrator          Organization Viewer
#      Project Administrator               Project Viewer
#      IAM Administrator                   IAM Viewer
#      AD/LDAP Administrator               AD/LDAP Viewer
#
#  Role: info_sec
#    Permissions:
#      Organization Viewer                 DNS Administrator
#      Project Viewer                      WAF Administrator
#      IAM Administrator                   Firewall Administrator
#      AD/LDAP Administrator
#
#2) Advanced Roles
#  Role: net_sec                       Role: security
#    Permissions:                        Permissions:
#      Organization Viewer                 Organization Viewer
#      Project Viewer                      Project Viewer
#      Network Administrator               IAM Viewer
#      Firewall Administrator              AD/LDAP Viewer',
#    :answers => [ :basic, :advanced ],
#    :validation => 1..2,
#    :answer_type => :default,
#    :question => "Security Roles?"
#  }],

]


class role::wordpress {
  include ::profile::base
  include ::profile::security::external
  include ::profile::blog::wordpress
}

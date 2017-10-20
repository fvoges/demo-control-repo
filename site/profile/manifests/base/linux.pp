class profile::base::linux {
  $kernel  = $facts['kernel'].downcase
  $family  = $facts['os']['family'].downcase

  include "::profile::base::${kernel}::${family}"

  include ::profile::firewall
  include ::profile::base::ntp
  include ::profile::base::ssh
}

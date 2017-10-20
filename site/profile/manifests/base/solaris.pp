class profile::base::solaris (
  Boolean $enable_netbackup,
) {
  $kernel  = $facts['kernel'].downcase
  $release = $facts['os']['release']['major']
  $family  = $facts['os']['family'].downcase

  include "::profile::base::${kernel}::${family}::${family}${release}"

  include ::profile::firewall
  include ::profile::base::ntp
  include ::profile::base::ssh

  if $enable_netbackup {
    include ::profile::backup::netbackup
  }
}

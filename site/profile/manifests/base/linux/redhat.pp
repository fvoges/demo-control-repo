class profile::base::linux::redhat (
  Hash[Hash] $packages,
  Hash[Hash] $services,
) {
  $kernel  = $facts['os']['kernel'].downcase
  $family  = $facts['os']['family'].downcase
  $release = $facts['os']['release']['major']

  if $facts['os']['name'] == 'RedHat' {
    include ::profile::base::redhat::rhn_repos
  } else {
    include ::profile::base::redhat::yumrepos
  }

  include "::profile::base::${kernel}::${family}::${family}${release}"

  $packages.each | $p, $a | {
    package { $p:
      ensure => $a['ensure'],
    }
  }

  $services.each | $s, $a | {
    $enable = ( $a['ensure'] == 'running' )

    service { $s:
      ensure => $a['ensure'],
      enable => $enable,
    }
  }
}

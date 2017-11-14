class profile::base::linux::redhat::redhat6 (
  Hash $packages,
  Hash $services,
) {

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

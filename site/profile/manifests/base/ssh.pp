# Profile profile::base::ssh
class profile::base::ssh (
  Enum['yes','no']                                           $ssh_forward_agent            = 'no',
  Enum['yes','no']                                           $ssh_hash_known_hosts         = 'yes',
  Enum['yes','no']                                           $sshd_allow_agent_forwarding  = 'no',
  Enum['yes','no']                                           $sshd_allow_tcp_forwarding    = 'no',
  Enum['yes','no']                                           $sshd_allow_x11_forwarding    = 'no',
  Enum['yes','no']                                           $sshd_permit_empty_passwords  = 'no',
  Enum['yes','no']                                           $sshd_use_dns                 = 'no',
  Enum['yes','no']                                           $sshd_password_authentication = 'yes',
  Enum['yes','no','without-password','forced-commands-only'] $sshd_permit_root_login       = 'yes',
) {
  Sshd_config {
    require => Class['::ssh::config'],
    notify  => Class['::ssh::service'],
  }

  ssh_config { 'ForwardAgent':
    ensure => present,
    value  => $ssh_forward_agent,
  }

  ssh_config { 'HashKnownHosts':
    ensure => present,
    value  => $ssh_hash_known_hosts,
  }

  sshd_config { 'PermitRootLogin':
    ensure => present,
    value  => $sshd_permit_root_login,
  }

  sshd_config { 'UseDNS':
    ensure => present,
    value  => $sshd_use_dns,
  }

  sshd_config { 'X11Forwarding':
    ensure => present,
    value  => $sshd_allow_x11_forwarding,
  }

  sshd_config { 'AllowAgentForwarding':
    ensure => present,
    value  => $sshd_allow_agent_forwarding,
  }

  sshd_config { 'PermitEmptyPasswords':
    ensure => present,
    value  => 'no',
  }

  sshd_config { 'IgnoreRhosts':
    ensure => present,
    value  => 'yes',
  }

  sshd_config { 'MaxAuthTries':
    ensure => present,
    value  => '2',
  }

  sshd_config { 'Protocol':
    ensure => present,
    value  => '2',
  }

  class { '::ssh': }
}

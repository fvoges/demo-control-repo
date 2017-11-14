class profile::puppet::agent::cached_catalog (
  Boolean $use_cached_catalog = false,
) {
  ini_setting { 'puppet.conf agent:use_cached_catalog':
    ensure  => present,
    path    => $::settings::config,
    section => 'agent',
    setting => 'use_cached_catalog',
    value   => $use_cached_catalog,
  }
}
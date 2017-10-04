class profile::puppet::master {

  package { 'puppetserver hiera-eyaml':
    ensure   => present,
    name     => 'hiera-eyaml',
    provider => 'puppetserver_gem',
    notify   => Service['pe-puppetserver'],
  }

  package { 'puppet hiera-eyaml':
    ensure   => present,
    name     => 'hiera-eyaml',
    provider => 'puppet_gem',
    notify   => Service['pe-puppetserver'],
  }

  file { ['/etc/puppetlabs/secure', '/etc/puppetlabs/secure/keys']:
    ensure => directory,
    owner  => 'pe-puppet',
    group  => 'pe-puppet',
    mode   => '0750',
  }

  ini_setting { 'puppet.conf main:hiera_config':
    ensure  => present,
    path    => $::settings::config,
    section => 'main',
    setting => 'hiera_config',
    value   => "${settings::environmentpath}/production/hiera.yaml",
    notify  => Service['pe-puppetserver'],
  }

  ini_setting { 'puppet.conf master:hiera_config':
    ensure  => absent,
    path    => $::settings::config,
    section => 'master',
    setting => 'hiera_config',
    notify  => Service['pe-puppetserver'],
  }
}

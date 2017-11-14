class profile::puppet::loadbalancer (
) {
  $certs_d = '/etc/haproxy/certs.d'
  include ::haproxy

  file { $certs_d:
    ensure => directory,
    owner  => 'haproxy',
    group  => 'haproxy',
    mode   => '0755',
  }

  file { "${certs_d}/puppet_cacrt.pem":
    ensure  => file,
    owner   => 'haproxy',
    group   => 'haproxy',
    mode    => '0644',
    content => file($settings::cacert),
  }

  file { "${certs_d}/puppet_cacrl.pem":
    ensure  => file,
    owner   => 'haproxy',
    group   => 'haproxy',
    mode    => '0644',
    content => file($settings::cacrl),
  }

  haproxy::listen { 'puppet00':
    ipaddress => '0.0.0.0',
    ports     => '8140',
    options   => {
      'balance' => 'leastconn',
      'mode'    => 'tcp',
      # 'httpchk' => 'get /status/v1/simple',
    },
  }

  haproxy::listen { 'orchestrator00':
    ipaddress => '0.0.0.0',
    ports     => '8142',
    options   => {
      'mode'  => 'tcp',
    },
  }

  haproxy::listen { 'stats':
    ipaddress => '0.0.0.0',
    ports     => '9090',
    options   => {
      'mode'  => 'http',
      'stats' => ['uri /', 'auth puppet:puppet'],
    },
  }
}
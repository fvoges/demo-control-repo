class profile::blog::wordpress (
  Variant[String,Sensitive[String]] $mysql_root_pass,
  String                            $docroot,
  String                            $wp_user,
  Variant[String,Sensitive[String]] $wp_pass,
  String                            $wp_group,
  String                            $db_name,
  String                            $db_user,
  Variant[String,Sensitive[String]] $db_pass,
  Optional[String]                  $lb_pool_name = undef,
) {
  # ensure that all sensitive data is flagged as sensitive
  $_mysql_root_pass = Sensitive($mysql_root_pass)
  $_wp_pass         = Sensitive($wp_pass)
  $_db_pass         = $db_pass # Module doesn't support Sensitive($db_pass)
  include ::vsftpd
  user { $wp_user:
    ensure     => present,
    password   => $_wp_pass,
    gid        => $wp_group,
    managehome => true,
  }

  group { $wp_group:
    ensure => present,
  }

  file { '/etc/ftpusers':
    ensure => file,
  }

  file_line { "${wp_user} user FTP access":
    ensure => present,
    path   => '/etc/ftpusers',
    line   => $wp_user,
  }
  include ::apache
  include ::apache::mod::php
  class { '::mysql::server':
    root_password => $_mysql_root_pw,
  }
  class { '::mysql::bindings':
    php_enable => true,
    notify     => Class['::apache::service'],
  }
  apache::vhost { $::fqdn:
    docroot        => $docroot,
    manage_docroot => false,
  }
  class { '::wordpress':
    install_dir => $docroot,
    wp_owner    => $wp_user,
    wp_group    => $wp_group,
    db_name     => $db_name,
    db_user     => $db_user,
    db_password => $_db_pass,
  }
  if $lb_pool_name {
    @@haproxy::balancermember { $facts['networking']['fqdn']:
      listening_service => $lb_pool_name,
      server_names      => $facts['networking']['hostname'],
      ipaddresses       => $facts['networking']['ip'],
      ports             => '80',
      options           => 'check',
    }
  }
}

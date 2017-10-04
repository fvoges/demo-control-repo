class profile::base::ntp (
  Varian[String,Array] $servers = 'pool.ntp.org',
){

  class { '::ntp':
    servers => $servers,
  }
}
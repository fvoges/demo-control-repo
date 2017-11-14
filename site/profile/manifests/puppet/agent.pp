class profile::puppet::agent (
) {
  $version = pe_compiling_server_aio_build()

  class { '::puppet_agent':
    package_version => $version,
  }
}

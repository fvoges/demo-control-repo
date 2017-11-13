class profile::puppet::agent (
) {
  $version = versioncmp(pe_compiling_server_aio_build(), aio_agent_version) > 0 ? {
    true    => pe_compiling_server_aio_build(),
    default => aio_agent_version,
  }

  class { '::puppet_agent':
    version => $version,
  }
}
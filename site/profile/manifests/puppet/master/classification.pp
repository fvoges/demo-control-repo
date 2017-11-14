class profile::puppet::master::classification {
  node_group { 'PE Upgrade':
    ensure               => 'present',
    classes              => {
      'profile::puppet::agent'                 => {},
      'profile::puppet::agent::cached_catalog' => {
        'use_cached_catalog' => true,
      },
    },
    environment          => 'upgrade',
    override_environment => true,
    parent               => 'All Nodes',
    rule                 => ['and', ['~', 'name', 'agent-el']],
  }

  node_group { 'PE Master Classification':
    ensure               => 'present',
    classes              => {
      'profile::puppet::master::classification' => {},
    },
    environment          => 'production',
    override_environment => false,
    parent               => 'Puppet Enterprise',
    rule                 => ['and', ['~', 'name', 'master']],
  }

  node_group { 'PE Compile Master':
    ensure               => 'present',
    classes              => {
      'profile::puppet::balancermember' => {},
    },
    environment          => 'production',
    override_environment => false,
    parent               => 'Puppet Enterprise',
    rule                 => ['and', ['~', 'name', 'compile']],
  }
}
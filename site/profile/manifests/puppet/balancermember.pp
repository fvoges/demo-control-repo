class profile::puppet::balancermember () {
  $certs_d = '/etc/haproxy/certs.d'
  $cacrt   = "${certs_d}/puppet_cacrt.pem"
  $cacrl   = "${certs_d}/puppet_cacrl.pem"

# listen puppet-agent
#   bind *:8140
#   balance leastconn
#   mode tcp
#   option httpchk get /status/v1/simple
#   server pe-compiler-slice-1.example.com 192.168.0.187:8140 ca-file /etc/haproxy/certs.d/puppet_cacrt.pem crl-file /etc/haproxy/certs.d/puppet_cacrl.pem port 8140 verify required check check-ssl
#   server pe-compiler-slice-2.example.com 192.168.0.188:8140 ca-file /etc/haproxy/certs.d/puppet_cacrt.pem crl-file /etc/haproxy/certs.d/puppet_cacrl.pem port 8140 verify required check check-ssl

  @@haproxy::balancermember { "puppet_${trusted['certname']}":
    listening_service => 'puppet00',
    server_names      => $trusted['certname'],
    ipaddresses       => $facts['networking']['interfaces']['eth1']['ip'],
    ports             => '8140',
    options           => [
      'check',
      'check-ssl',
      "ca-file ${cacrt}",
      "crl-file ${cacrl}",
      'port 8140',
      'verify required',
    ],
  }

  @@haproxy::balancermember { "orchestrator_${trusted['certname']}":
    listening_service => 'orchestrator00',
    server_names      => $trusted['certname'],
    ipaddresses       => $facts['networking']['interfaces']['eth1']['ip'],
    ports             => '8142',
    options           => [
      'check',
      'check-ssl',
      "ca-file ${cacrt}",
      "crl-file ${cacrl}",
      'port 8142',
      'verify required',
    ],
  }
}
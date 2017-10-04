class profile::base {
  $kernel  = $facts['os']['kernel'].downcase

  include "::profile::base::${kernel}"
}

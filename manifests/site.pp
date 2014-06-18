node 'ams-galera00.puppetlabs.vm' {
  include role::galeramaster
}

node /^ams-galera\d{2}.puppetlabs.vm$/ {
  include role::galera
}

node 'master.puppetlabs.vm' {
  notify{ 'Not puppetised for this demo': }
}

node default {
  fail("The node ${::fqdn} is not known to this puppet repository. Please add it to site.pp and try again")
}

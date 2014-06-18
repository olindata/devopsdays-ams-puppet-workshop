class profile::galera {
  include profile::mysql

  include ::galera

  include galera::health_check

  # load haproxy frontends
  $balancermembers = hiera_hash('profile::galera::balancermembers', undef)

  if $balancermembers {
    create_resources('@@haproxy::balancermember', $balancermembers)
  }

}

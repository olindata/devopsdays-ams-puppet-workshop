class profile::haproxy {
  include ::haproxy

  # load haproxy frontends
  $listens = hiera_hash('profile::haproxy::listen', undef)

  if $listens {
    create_resources('haproxy::listen', $listens)
  } else {
    fail('No listen settings found in hiera in class profile::haproxy.')
  }

}

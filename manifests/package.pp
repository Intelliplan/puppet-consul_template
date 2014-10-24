class consul_template::package {

  package { 'consul-template':
    ensure => 'present',
  }
}

# == Class: consul_template::package
#
# Installs the consul-template package.
#
class consul_template::package {

  package { 'consul-template':
    ensure => 'present',
  }
}

# == Class: consul_template::service
#
# Creates an init script and starts the service.
#
class consul_template::service {

  file {'/etc/init.d/consul-template':
    ensure => present,
    source => 'puppet:///modules/consul_template/consul-template',
    mode   => '0755',
    owner  => '0',
    group  => '0',

  }

  service { 'consul-template':
    ensure  => 'running',
    enable  => 'true',
    require => File['/etc/init.d/consul-template'],
  }


}

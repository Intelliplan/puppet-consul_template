# == Class: consul_template::service
#
# Creates an init script and starts the service.
#
class consul_template::service {
  file { '/etc/init.d/consul-template':
    ensure => present,
    group  => '0',
    mode   => '0755',
    owner  => '0',
    source => 'puppet:///modules/consul_template/consul-template',
  }

  service { 'consul-template':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/init.d/consul-template'],
  }
}

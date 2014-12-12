# == Class: consul_template::service
#
# Starts the service.
#
class consul_template::service {
  service { 'consul-template':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/init.d/consul-template'],
  }
}

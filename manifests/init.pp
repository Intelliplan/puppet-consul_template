# == Class: consul_template
#
# @TODO: Full description of class consul_template here.
#
# === Parameters
#
# [*consul_host*]
#   Host/IP consul is running on. Defaults to `127.0.0.1`.
#
# [*consul_port*]
#   Port consul is running on. Defaults to `8500`.
#
# === Examples
#
#   include consul_template
#   consul_template::template {'nginx':
#     source      => '/etc/consul-template/nginx.conf.ctmpl',
#     destination => '/tmp/nginx-snippet.conf',
#     command     => '/etc/init.d/nginx restart',
#   }
#
# === Authors
#
# Kris Buytaert <kris.buytaert@inuits.eu>
#
# === Copyright
#
# Copyright 2014 Kris Buytaert, unless otherwise noted.
#
class consul_template (
  $consul_host = '127.0.0.1',
  $consul_port = '8500'
)

{

  include consul_template::package
  include consul_template::config
  include consul_template::service

}

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
  $consul_host          = '127.0.0.1',
  $consul_port          = '8500',
  $bin_dir              = '/usr/local/bin',
  $arch                 = $consul_template::params::arch,
  $version              = $consul_template::params::version,
  $install_method       = $consul_template::params::install_method,
  $download_url         = "https://github.com/hashicorp/consul-template/releases/download/v${version}/consul-template_${version}_linux_${arch}.tar.gz",
  $download_extract_dir = '/tmp',
  $package_name         = $consul_template::params::package_name,
  $package_ensure       = $consul_template::params::package_ensure,
  $init_style           = $consul_template::params::init_style,
) inherits consul_template::params {
  class { 'consul_template::install': } ->
  class { 'consul_template::config': } ->
  class { 'consul_template::service': }
}

# == Class: consul_template::config
#
# Configures consul_template:
# Creates required directories and initial configuration file.
#
class consul_template::config {


  file { '/etc/consul-template/':
    ensure => 'directory',
    group  => '0',
    mode   => '0755',
    owner  => '0',
  }


  concat { '/etc/consul-template/consul-template.hcl':
    group => '0',
    mode  => '0644',
    owner => '0',
  }

  concat::fragment {'header':
    target  => '/etc/consul-template/consul-template.hcl',
    order   => 0,
    content => template('consul_template/consul-template.hcl.header.erb'),
  }



}

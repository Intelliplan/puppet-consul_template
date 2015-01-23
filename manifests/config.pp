# == Class: consul_template::config
#
# Configures consul_template:
# Creates required directories and initial configuration file.
#
class consul_template::config {

  if $consul_template::init_style {
    case $consul_template::init_style {
      'upstart' : {
        file { '/etc/init/consul-template.conf':
          mode    => '0444',
          owner   => 'root',
          group   => 'root',
          content => template('consul_template/consul-template.upstart.erb'),
        }
        file { '/etc/init.d/consul-template':
          ensure => link,
          target => "/lib/init/upstart-job",
          owner  => root,
          group  => root,
          mode   => 0755,
        }
      }
      'sysv' : {
        file { '/etc/init.d/consul-template':
          mode    => '0555',
          owner   => 'root',
          group   => 'root',
          content => template('consul_template/consul-template.sysv.erb')
        }
      }
    }
  }

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

  concat::fragment { 'header':
    content => template('consul_template/consul-template.hcl.header.erb'),
    order   => 0,
    target  => '/etc/consul-template/consul-template.hcl',
  }
}

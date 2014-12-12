# == Class: consul_template::install
#
# Installs consul-template.
#
class consul_template::install {

  if $consul_template::install_method == 'url' {
    $download_file = "${consul_template::download_extract_dir}/consul-template_${consul_template::version}_linux_${consul_template::arch}/consul-template"

    staging::deploy { 'consul-template.tar.gz':
      source => $consul_template::download_url,
      target => $consul_template::download_extract_dir
    }->
    exec { "consul-template-${consul_template::version} copy to ${consul_template::bin_dir}":
      command => "cp -a ${$download_file} ${consul_template::bin_dir}",
      creates => "${consul_template::bin_dir}/consul-template",
      path    => '/bin'
    }
    ->
    file { "${consul_template::bin_dir}/consul-template":
      owner => 'root',
      group => 'root',
      mode  => '0555',
    }
  } elsif $consul_template::install_method == 'package' {
    package { $consul_template::package_name:
      ensure => $consul_template::package_ensure,
    }
  }
  else {
    fail("The provided install method ${consul_template::install_method} is invalid")
  }

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
}

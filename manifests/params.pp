# == Class consul_template::params
#
# This class is meant to be called from consul_template
# It sets variables according to platform
#
class consul_template::params {

  $install_method    = 'package'
  $package_name      = 'consul-template'
  $package_ensure    = 'latest'
  $version           = '0.4.0'

  case $::architecture {
    'x86_64', 'amd64': { $arch = 'amd64' }
    'i386':            { $arch = '386'   }
    default:           { fail("Unsupported kernel architecture: ${::architecture}") }
  }

  $init_style = $::operatingsystem ? {
    'Ubuntu'             => $::lsbdistrelease ? {
      /(10|12|14)\.04/ => 'upstart',
      default => undef
    },
    /CentOS|RedHat/      => $::operatingsystemmajrelease ? {
      /(4|5|6)/ => 'sysv',
      default   => undef,
    },
    'Fedora'             => $::operatingsystemmajrelease ? {
      /(12|13|14)/ => 'sysv',
      default      => undef,
    }
  }
}

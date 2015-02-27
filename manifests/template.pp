# == Definition: consul_template::template
#
# Create a new template fragment using concat::fragment
#
# === Parameters:
#
# [*source*]:
#   Template source to add to the consul-template configuration
#
# [*destination*]:
#   Template destination to add to the consul-template configuration
#
# [*command*]:
#   Optional command to run when the template is updated. Defaults to undefined.
#
define consul_template::template (
  $command = undef,
  $destination,
  $source,
) {
  File[$source] ~> Service['consul-template']

  concat::fragment {"template-${name}":
    content => template('consul_template/consul-template.hcl.snippet.erb'),
    order   => 10,
    target  => '/etc/consul-template/consul-template.hcl',
  }
}

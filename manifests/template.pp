define consul_template::template (
  $source,
  $destination,
  $command,
)
{

  concat::fragment {"template-$name":
    target  => '/etc/consul-template/consul-template.hcl',
    order   => 10,
    content => template('consul_template/consul-template.hcl.snippet.erb'),
  }


}

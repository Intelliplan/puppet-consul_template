require 'spec_helper'

describe 'consul_template', :type => :class do
  let (:facts) { debian_facts }
  let (:pre_condition) { '$concat_basedir = "/tmp"' }

  describe 'without parameters' do
    it { should create_class('consul_template') }
    it { should contain_class('consul_template::package') }
    it { should contain_class('consul_template::config') }
    it { should contain_class('consul_template::service') }
  end

  describe 'with parameter: consul_host' do
    let (:params) { { :consul_host => '10.10.10.10' } }

    it { should contain_concat__fragment('header').with(
        'content' => /10.10.10.10/
      )
    }
  end

  describe 'with parameter: consul_host as unix socket' do
    let (:params) { { :consul_host => 'unix:///path/to/socket' } }

    it { should contain_concat__fragment('header').with(
        'content' => %r{/path/to/socket\n}
      )
    }
  end

  describe 'with parameter: consul_port' do
    let (:params) { { :consul_port => '1111' } }

    it { should contain_concat__fragment('header').with(
        'content' => /1111/
      )
    }
  end
end


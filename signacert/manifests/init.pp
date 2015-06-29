# == Class: signacert
#
# Full description of class signacert here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'signacert':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class signacert {
  user { 'signacert':
    ensure     => 'present',
    gid        => 'signacert',
    groups     => ['wheel'],
    shell      => '/bin/bash',
    home       => '/home/signacert',
    managehome => true,
  }
  ssh_authorized_key { 'sigancert':
    ensure => 'present',
    type   => 'ssh-rsa',
    key    => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAy5WxN4CcVdhLNkIU4eKsJJzyyPmXmnD+tAa4gkigLws/G0/jF8yNu8kZZlH9D44Z06Vf/7smX6GEb28IjF7892cfMszK19Yy4cH3gHD59wXUEPv/0ELeKJv2Efiusi55bFopdH8bgpvlgYHq2bto7IGLiyDH5Pad9QRiDH9i9B9fmVAYYITdb8x4ZlXBo3mfEJ4gfwo38a9ZBbSUO56kfu/iMPgvRZKepOsV1Ih3pkpnd4BdK/GDs6VSL3vbVly+U21Qg8zL3K5gJptTD2VudXLp95JdsQsKEzlhgUybAHsDwIZj6LZe5JXvvqWjwFZOlQlfHF42tN1BNd8kaWX5yQ== signacert@sd-staging-cardholder1.inside.globalcashcard.com',
    user   => 'signacert',
  }
  file { '/tmp/signacert_oval-5_8_0_2-rhel6_x64.tar.gz':
    ensure => 'present',
    source => 'puppet:///modules/signacert/signacert_oval-5_8_0_2-rhel6_x64.tar.gz',
    mode   => '0755',
    owner  => 'signacert',
    group  => 'wheel',
  }
  exec { 'signa_oval_install':
    command   => 'tar -xzvf /tmp/signacert_oval-5_8_0_2-rhel6_x64.tar.gz -C /opt; rm -rf /tmp/signacert_oval-5_8_0_2-rhel6_x64.tar.gz',
    creates   => '/opt/signacert_oval',
    logoutput => true,
  }
  file { '/tmp/signacert_tools-5_8_0_2-linux_x64.tar.gz':
    ensure => 'present',
    source => 'puppet///modules/signacert/signacert_tools-5_8_0_2-linux_x64.tar.gz',
    mode   => '0755',
    owner  => 'signacert',
    group  => 'wheel',
  }
  exec { 'signa_tools_install'
    command   => 'tar -xzvf /tmp/signacert_tools-5_8_0_2-linux_x64.tar.gz -C /opt; rm -rf /tmp/signacert_tools-5_8_0_2-linux_x64.tar.gz',
    creates   => '/opt/signacert/jre/',
    logoutput => true,
  }
    

# == Class: signacert
#
# Creates a user for SignaCert and installs it on target hosts. Included in the ::security:: profile.
#
# === Authors
#
# Brian Woodard <bwoodard@globalcashcard.com>
# Cesar Covarrubias <ccovarrubias@globalcashcard.com>
#
# === Copyright
#
# Copyright 2015 Global Cash Card, unless otherwise noted.
#
class signacert {
  user { 'signacert':
    ensure     => 'present',
    groups     => ['signacert'],
    shell      => '/bin/bash',
    home       => '/home/signacert',
    managehome => true,
	require    => Group['signacert'],
  }

  group { "signacert":
    ensure => "present",
  }
  ssh_authorized_key { 'sigancert':
    ensure => 'present',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAy5WxN4CcVdhLNkIU4eKsJJzyyPmXmnD+tAa4gkigLws/G0/jF8yNu8kZZlH9D44Z06Vf/7smX6GEb28IjF7892cfMszK19Yy4cH3gHD59wXUEPv/0ELeKJv2Efiusi55bFopdH8bgpvlgYHq2bto7IGLiyDH5Pad9QRiDH9i9B9fmVAYYITdb8x4ZlXBo3mfEJ4gfwo38a9ZBbSUO56kfu/iMPgvRZKepOsV1Ih3pkpnd4BdK/GDs6VSL3vbVly+U21Qg8zL3K5gJptTD2VudXLp95JdsQsKEzlhgUybAHsDwIZj6LZe5JXvvqWjwFZOlQlfHF42tN1BNd8kaWX5yQ==',
    user   => 'signacert',
  }
  if $::signacertinstalled == false {
    file { '/tmp/signacert_oval-5_8_0_2-rhel6_x64.tar.gz':
      ensure => 'present',
      source => 'puppet:///modules/signacert/signacert_oval-5_8_0_2-rhel6_x64.tar.gz',
      mode   => '0755',
      owner  => 'signacert',
      group  => 'wheel',
    }
    exec { 'signa_oval_install':
      command   => 'tar -xzvf /tmp/signacert_oval-5_8_0_2-rhel6_x64.tar.gz -C /opt; rm -rf /tmp/signacert_oval-5_8_0_2-rhel6_x64.tar.gz',
      path      => "/bin",
      require   => File['/tmp/signacert_oval-5_8_0_2-rhel6_x64.tar.gz'],
      creates   => '/opt/signacert/signaclient/',
      logoutput => true,
    }
    file { '/tmp/signacert_tools-5_8_0_2-linux_x64.tar.gz':
      ensure => 'present',
      source => 'puppet///modules/signacert/signacert_tools-5_8_0_2-linux_x64.tar.gz',
      mode   => '0755',
      owner  => 'signacert',
      group  => 'wheel',
    }
    exec { 'signa_tools_install':
      command   => 'tar -xzvf /tmp/signacert_tools-5_8_0_2-linux_x64.tar.gz -C /opt; rm -rf /tmp/signacert_tools-5_8_0_2-linux_x64.tar.gz',
      path      => "/bin",
      require   => File['/tmp/signacert_tools-5_8_0_2-linux_x64.tar.gz'],
      creates   => '/opt/signacert/jre/',
      logoutput => true,
    }
}
}

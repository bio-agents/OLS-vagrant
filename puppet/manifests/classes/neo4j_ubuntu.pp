# == Class: neo4j::ubuntu
#
# Everything you need to get Neo4j running on Ubuntu.  This first draft is meant to be self-contained for first
# time users, we'll see what we can do to make a module that can be user by the Puppet Forge community.
#
# === Parameters
#
# None.
#
# === Variables
# None.
#
# === Examples
#
#  class { neo4j::ubuntu }
#
# === Authors
#
# Author Name <julian.simpson@neotechnology.com>
#
# === Copyright
#
# Copyright 2012 Neo Technology Inc.
#
class neo4j::ubuntu {

  exec {
    'apt-get update':
      command => '/usr/bin/apt-get update';

    'neotech signing key':
      command => '/usr/bin/wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -',
      before  => Exec['apt-get update'],
      unless  => '/usr/bin/apt-key list | grep -q neotechnology.com';

    'restart neo4j':
      command     => '/usr/sbin/service neo4j-service restart',
      require     => [Package['neo4j'],
      ];

  }

  file {
    'neo4j contrib dir':
      ensure => directory,
      path   => '/usr/share/neo4j-contrib';

    'neo4j apt config':
      path    => '/etc/apt/sources.list.d/neo4j.list',
      content => 'deb http://debian.neo4j.org/repo stable/',
      before  => Exec['apt-get update'];
  }

  package {
    'neo4j':
      ensure  => present,
      require => Exec['apt-get update'];
  }

  service {
    'neo4j-service':
      ensure  => running,
      enable  => true,
      require => Exec['restart neo4j'],
  }

}

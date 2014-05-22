# == Class neo4j::params
#
# This class is meant to be called from neo4j
# It sets variables according to platform
#
class neo4j::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'neo4j'
      $service_name = 'neo4j'
    }
    'RedHat', 'Amazon': {
      $package_name = 'neo4j'
      $service_name = 'neo4j'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

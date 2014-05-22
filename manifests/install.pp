# == Class neo4j::install
#
class neo4j::install {

  package { $neo4j::package_name:
    ensure => present,
  }
}

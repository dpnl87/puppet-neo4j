# == Class neo4j::config
#
# This class is called from neo4j
#
class neo4j::config {

  file { '/etc/neo4j/neo4j-server.properties':
    ensure  => present,
    content => template('neo4j/neo4j-server.properties.erb')
  }

}

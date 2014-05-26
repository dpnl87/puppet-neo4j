# == Class neo4j::repo
#
# This class is called from neo4j
#
class neo4j::repo {

  yumrepo { 'neo4j':
    name      => 'neo4j',
    baseurl   => 'http://yum.neo4j.org',
    enabled   => 1,
    gpgcheck  => 1,
    gpgkey    => 'http://debian.neo4j.org/neotechnology.gpg.key',
  }


}

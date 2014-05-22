# == Class neo4j::service
#
# This class is meant to be called from neo4j
# It ensure the service is running
#
class neo4j::service {

  service { $neo4j::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}

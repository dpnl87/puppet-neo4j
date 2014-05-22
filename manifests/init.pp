# == Class: neo4j
#
# Full description of class neo4j here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class neo4j (
  $install_from_file = undef,
  $install_from_repo = undef,
  $package_name = $neo4j::params::package_name,
  $service_name = $neo4j::params::service_name,
) inherits neo4j::params {

  if !$install_from_repo and !$install_from_file {
    fail('You need to specify a way for package installation.')
  }

  class { 'neo4j::install': } ->
  class { 'neo4j::config': } ~>
  class { 'neo4j::service': } ->
  Class['neo4j']
}

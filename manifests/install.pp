# == Class neo4j::install
#
class neo4j::install {

  # If 'installation_source' set to file use rpm file to install
  if $neo4j::installation_source == 'file' {

    file { "/tmp/${neo4j::package_name}.rpm":
      source => "puppet:///modules/neo4j/${neo4j::package_name}.rpm",
    }

    package { 'java-1.7.0-openjdk':
      ensure => present,
    }

    package { $neo4j::package_name:
      ensure   => present,
      provider => 'rpm',
      source   => "/tmp/${neo4j::package_name}.rpm",
      require  => [
        File["/tmp/${neo4j::package_name}.rpm"],
        Package['java-1.7.0-openjdk'],
      ],
    }
  }

  # If 'installation_source' set to repo use repository to install
  if $neo4j::installation_source == 'repo' {
    include ::neo4j::repo

    package { $neo4j::package_name:
      ensure  => present,
      require => Yumrepo[$neo4j::repo_name],
    }

  }
}

# == Class neo4j::install
#
class neo4j::install {

  # If 'install_from_file' set to true use rpm file to install
  if $neo4j::install_from_file {

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

  # If 'install_from_repo' set to true use repository to install
  if $neo4j::install_from_repo {

    package { $neo4j::package_name:
      ensure  => present,
      require => Yumrepo[$neo4j::repo_name],
    }

  }
}

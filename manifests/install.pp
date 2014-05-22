# == Class neo4j::install
#
class neo4j::install {

  # If 'install_from_file' set to true use rpm file to install
  if $neo4j::install_from_file {

    file { "/tmp/${neo4j::package_name}":
      source => "puppet:///modules/neo4j/files/${neo4j::package_name}",
    }

    package { $neo4j::package_name:
      ensure   => present,
      provider => 'rpm',
      source   => "/tmp/${neo4j::package_name}",
      require  => File["/tmp/${neo4j::package_name}"],
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

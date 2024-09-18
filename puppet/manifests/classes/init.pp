class init {

    #group { "puppet":
    #   ensure => "present",
    #}

    # Update the system
    exec { "update-apt":
        command => "sudo apt-get update",
    }

    # Install the first set of dependencies from apt
    package {
        ["mongodb", "maven", "git", "curl", "tar", "bash", "solr-jetty", "tomcat7"]:
        ensure => installed,
        require => Exec['update-apt'] # The system update needs to run first
    }

    file { "/etc/default/jetty":
        source => "/vagrant/scripts/etc/default/jetty.default",
        require => Package["solr-jetty"],
    }

    service { "jetty":
        ensure => running,
	require => Package["solr-jetty"]
    }

    service { "mongodb":
        ensure => running,
        require => Package["mongodb"]
    }

}

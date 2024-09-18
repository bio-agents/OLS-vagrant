class ols {

   # group { "puppet":
   #     ensure => "present",
   # }

    file { "/vagrant/ols":
        ensure => directory,
        before => Exec["download_ols"],
       
    }

    exec { "download_ols":
        cwd => "/vagrant",
        command => "git clone https://github.com/EBISPOT/OLS.git",
        user => "vagrant",
        require => Package["git"],
        logoutput => true,
        timeout => '0'
    }

    exec { "build_ols":      
        cwd => "/vagrant/ols",
        command => "mvn clean package",
        user => "vagrant",
        require => Package["maven"],
        logoutput => true,
        timeout => '0'
    }


    #exec { "invoke_ols_importer_app":
    #    cwd => "/vagrant/ols/ols-app/ols-config-importer/target",
    #    command => "java -jar ols-config-importer.jar",
    #    user => "vagrant",
    #    require => Package["mongodb"],
    #    logoutput => on_failure,
    #    timeout => '300'
    #}
  
    #exec { "invoke_ols_indexer_app":
    #    cwd => "/vagrant/ols/ols-app/ols-loading-app/target",
    #    command => "java -jar  -Xms256m -Xmx2048m ols-indexer.jar",
    #    user => "vagrant",
    #    require => Package["mongodb"],
    #    logoutput => true,
    #    timeout => '0'
    #}


}

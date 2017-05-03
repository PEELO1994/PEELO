class musamoduuli {

    exec { 'apt-update':
            command => '/usr/bin/apt-get update'
    }

    package { lmms:
            require => Exec['apt-update'],
            ensure => 'installed',
            allowcdrom => 'true',
    }

   
}

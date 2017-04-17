class apachemoi {

    exec { 'apt-update':
            command => '/usr/bin/apt-get update'
    }

    package { apache2:
            require => Exec['apt-update'],
            ensure => 'installed',
            allowcdrom => 'true',
    }

    file {'/var/www/html/index.html':
            content => "moi ilari hyvät setit siellä",
    }
}

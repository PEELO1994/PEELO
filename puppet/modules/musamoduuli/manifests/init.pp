class musamoduuli {

	exec { 'apt-update':
		command => '/usr/bin/apt-get update'
	}

	package { lmms:
		require => Exec['apt-update'],
		ensure => 'installed',
		allowcdrom => 'true',
	}

	package { guitarix:
		require => Exec['apt-update'],
		ensure => 'installed',
		allowcdrom => 'true',

	}

	package { hydrogen:
		require => Exec['apt-update'],
                ensure => 'installed',
                allowcdrom => 'true',

	}
	
	package { audacity:
                require => Exec['apt-update'],
                ensure => 'installed',
                allowcdrom => 'true',

	}
   
}

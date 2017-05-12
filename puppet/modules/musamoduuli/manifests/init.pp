# Start installed softwares with just typing the name on terminal example: lmms, guitarix
# bash apply.sh

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

	
	package { audacity:
                require => Exec['apt-update'],
                ensure => 'installed',
                allowcdrom => 'true',

	}


	exec { 'moi2':
		command => '/usr/bin/lmms',
		require => Package['lmms'],
	}


	exec { 'moi3':
		command => '/usr/bin/audacity',
		require => Package['audacity'],
	
	}


   
}

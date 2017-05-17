# Start installed softwares with just typing the name on terminal example: lmms, guitarix
# bash apply.sh

# WARNING!! This module is not completely safe because it is run by root. Use with your own responsibility.

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
		command => '/usr/bin/lmms &',
		require => Package['lmms'],
	}


	exec { 'moi3':
		command => '/usr/bin/audacity &',
		require => Package['audacity'],
	
	}

	exec { 'moi4':
		command => '/usr/bin/guitarix &',		
		require => Package['guitarix'],
	}	

   
}

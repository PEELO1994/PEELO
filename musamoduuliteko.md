# Musamoduuli

## Käyttötarkoitus

Tämän moduulin tarkoitus on asentaa käyttäjälle ilmaisia musiikin nauhoitus ja editointi ohjelmistoja.
Näiden sovellusten avulla aloitteleva köyhä muusikko voi opetella kuinka musiiki nauhoitus ja editointi toimii.
Moduuliin kuuluu seuraavat sovellukset: Lmms, Audacity, Guitarix jne.


## Eteneminen

Aloitin etsimällä internetistä millaisia erilaisia ilmaisia musiikinteko sovelluksia olisi tarjolla
ja etsin niistä mielestäni parhaat ja helppokäyttöisimmät. 
Itse tekemisen aloitin luomalla uuden moduulin githubiin jonka nimeksi tuli musamoduuli.

Itse tekemisen aloitin asentamalla puppetin ja luomalla polun puppet/modules/musamoduuli/manifests/init.pp.
sen jälkeen tein githubin repositoryyni start.sh ja apply.sh kansioit että voisin käynnistää moduulia bash.sh komennolla myöhemmin ja kokeilla aina kuinka moduuli toimii.
apply.sh tiedoston sisälle laitoin seuraavat tiedot:

        sudo puppet apply --modulepath puppet/modules/ -e 'class {musamoduuli:}'  
        
Tämän jälkeen aloitin tekemään init.pp kansioon moduuliani aloitin tekemällä sinne package tiedostoja jotka sisältävät guitarix:in, lmms:än ja audacityn. 
moduulini näytti sen jälkeen tältä
    
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
    
    
Halusin tämän jälkeen että moduuli päivittää ennen näiden asennusta terminaalin kautta koneen sudo apt-get updatella jotain lisäsin init.pp kansioon seuraavan koodinpätkän:

    exec { 'apt-update':
		  command => '/usr/bin/apt-get update'
      }
      
 Toimiakseen muokkasin start.sh tiedoston seuraavanlaiseksi
 
      sudo apt-get update
      git clone https://github.com/PEELO1994/PEELO.git
      bash apply.sh
      
      
 Tämän jälkeen halusin että kaikki ohjelmat asentuvat moduulista samanaikaisesti ja käynnistyvät yhtäaikaa kun ajan moduulin bash apply.sh komennolla joten lisäsin seuraavat asiat init.pp tiedostoon:
 
       exec { 'moi2':
		      command => '/usr/bin/lmms ',
		      require => Package['lmms'],
	        }
  

	      exec { 'moi3':
		      command => '/usr/bin/audacity ',
		      require => Package['audacity'],
	
	        }

	      exec { 'moi4':
	       	command => '/usr/bin/guitarix ',		
		       require => Package['guitarix'],
	         }	

Tämän jälkeen testasin ajaa moduulia taas kerran terminaalin kautta, mutta moduuli ei ajanut itseään loppuun vain avasi vain yhden sovelluksen kerralaan ja ei avannut muita ohjelmia ennenkuin olin sulkenut ensimmäiseksi auienneen lmms:ssän.
Tähän löysin ratkaisun että init.pp tiedostossa olevia exec kohtia täytyi muokata ja lisätä jokaisen perään merkki "&" jotta terminaali ajoi koko moduulin kerralaan ja aukaisi ohjelmat yhtäaikaisesti.
lopputulos oli tällainen:
              
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
      
Kaiken tämän tehtyäni koitin konfiguroida näitä kolmen ohjelman globaaleja konffeja mutta en löytänyt terminaalin kautta mihinkään näistä sovelluksista oikeastaan suurempaa konfiguraatiota mitä itse joutuisin muokata, koska ohjelmien tarkoitus on musiikinteko ja jokainen käyttäjä lisää omat tarvittavat sovelluksen sisäiset lisäosansa itse sitä käyttäessä.

Halusin kuitenkin tehdä jotain pientä lisäystä moduuliin, joten ajattelin koittaa lisätä asennuksen jälkeisen kiitoksen joka tulisi näkyviin terminaaliin moduulin suorituksen jälkeen.
Tämän ratkaisin luomalla uuden md tiedoston githubiini ja kirjoitin sinne haluamani asennuksen jälkeisen tervehdyksen ja lisäsin yksinkertaisesti molempiin apply.sh ja start.sh kansioihin vain komennon:
      
        cat moikka.md
        
näiden muutosten jälkeen asennuksen jälkeen terminaaliin tuli näkyviin haluamani viesti.

Lopullinen koodi näytti lopuksi tältä:

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

      



Lähteet:


http://stackoverflow.com/questions/3004811/how-do-you-run-multiple-programs-in-parallel-from-a-bash-script

http://terokarvinen.com/2017/aikataulu-%E2%80%93-palvelinten-hallinta-ict4tn022-2-%E2%80%93-5-op-uusi-ops-loppukevat-2017-p2

https://docs.puppet.com/puppet/latest/types/exec.html

https://docs.puppet.com/puppet/latest/types/package.html

https://www.tecmint.com/free-music-creation-or-audio-editing-softwares-for-linux/

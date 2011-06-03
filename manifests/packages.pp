class puppetmaster::packages {
	package { "puppet-server":
		ensure => installed,
	}

	service { "puppetmaster":
		ensure => running,
		enable => true,
	}
}

class puppetmaster::service {
	service {
		'puppetmaster':
			ensure => running,
			enable => true;
	}
}

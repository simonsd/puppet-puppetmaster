class puppetmaster::packages {
	package {
		'puppetmaster':
			name => 'puppet-server';
	}

	service {
		'puppetmaster':
			ensure => running,
			enable => true;
	}
}

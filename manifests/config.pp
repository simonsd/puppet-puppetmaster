class puppetmaster::config {
	file { "/etc/puppet/autosign.conf":
		ensure => present,
		owner => root,
		group => root,
		mode => 0644,
		source => "puppet:///config/autosign",
	}
}

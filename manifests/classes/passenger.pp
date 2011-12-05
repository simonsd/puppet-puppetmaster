class puppetmaster::passenger {
  if $puppetmaster::frontend == 'passenger' {
    class {
      '::apache':
        devel => yes;
      '::passenger':
        require => Class['apache'];
    }

    package {
      'rubygem-rack':;
    }

    file {
      "/etc/httpd/conf.d/puppetmaster.conf":
        content => template('puppetmaster/puppetmaster_apache.conf.erb'),
        notify => Service["${apache::apache}"];
      "/usr/share/puppet/rack":
        ensure => directory;
      "/usr/share/puppet/rack/puppetmasterd":
        ensure => directory;
      "/usr/share/puppet/rack/puppetmasterd/public": 
        ensure => directory;
      "/usr/share/puppet/rack/puppetmasterd/tmp":
        ensure => directory;
      "/usr/share/puppet/rack/puppetmasterd/config.ru":
        source => "/usr/share/puppet/ext/rack/files/config.ru",
        owner => puppet;
    }
  }
}

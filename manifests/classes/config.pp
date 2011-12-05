class puppetmaster::config {
  @file {
    '/etc/puppet/autosign.conf':
      owner => root,
      group => root,
      mode => 0644,
      content => template('puppetmaster/autosign.conf.erb');
  }

  concat::fragment {
    '/etc/puppet/puppet.conf-puppetmaster':
      target => '/etc/puppet/puppet.conf',
      order => '30',
      notify => Service['puppetmaster'],
      content => template('puppetmaster/puppet.conf-puppetmaster.erb'),
      require => Class['puppetmaster::packages'];
  }

  if $puppetmaster::autosign == 'true' {
    realize(File['/etc/puppet/autosign.conf'])
  }

  if $puppetmaster::storeconfigs == 'true' {
    class {
      "${puppetmaster::dbadapter}":
        rootpass => "${puppetmaster::dbrootpw}";
    }

    mysql_db {
      "${puppetmaster::dbname}":
        user => "${puppetmaster::dbuser}",
        host => "${puppetmaster::dbhost}",
        require => Mysql_user["${puppetmaster::dbuser}"];
    }

    mysql_user {
      "${puppetmaster::dbuser}":
        pass => "${puppetmaster::dbpassword}",
        host => "${puppetmaster::dbhost}";
    }
  }

  iptables::rule {
    'puppetmaster':
      dport => '8140';
  }

  openssl::certificate::x509 {
    'puppetmaster':
      commonname => "${puppetmaster::cert_commonname}",
      altnames => "${puppetmaster::cert_altnames}",
      country => "${puppetmaster::cert_country}",
      organisation => "${puppetmaster::cert_organisation}",
      base_dir => "${puppetmaster::cert_basedir}",
      owner => "${puppetmaster::cert_owner}";
  }
}

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

  if $puppetmaster::autosign == 'yes' {
    realize(File['/etc/puppet/autosign.conf'])
  }

  if $puppetmaster::storeconfigs == 'yes' {
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
}

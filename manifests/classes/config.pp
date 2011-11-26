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
}

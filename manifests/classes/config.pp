class puppetmaster::config {
  file {
    '/etc/puppet/autosign.conf':
      owner => root,
      group => root,
      mode => 0644,
      content => template('puppetmaster/autosign.conf.erb');
  }
}

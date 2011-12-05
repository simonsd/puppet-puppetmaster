class puppetmaster::environments {
  file {
    '/etc/puppet/environments':
      ensure => directory,
      owner => root,
      group => root,
      mode => 0644;
  }

  puppetmaster::environment {
    'production':;
    'development':;
  }
}

class puppetmaster::passenger {
  class {
    '::passenger':;
  }

  package {
    'rubygem-rack':;
  }

  file {
    "/etc/httpd/conf.d/passenger.conf":
      content => template('puppetmaster/puppetmaster_apache.conf.erb'),
      notify => Service[$webserver];
  }
}

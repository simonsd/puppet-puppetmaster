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

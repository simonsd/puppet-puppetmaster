import 'classes/*.pp'

class puppetmaster (
  $dbname = 'puppet',
  $dbuser = 'puppet',
  $dbpassword,
  $dbhost = 'localhost',
  $dbadapter = 'mysql',
  $dbrootpw,
  $dbsocket = '/var/run/mysqld/mysqld.sock',
  $storeconfigs = 'false',
  $autosign = 'no'
){
  include puppet
 
  class {
    'puppetmaster::packages':;
    'puppetmaster::config':;
    'puppetmaster::service':;
  }

  if $puppetmaster::storeconfigs == 'true' {
    class {
      "${puppetmaster::dbadapter}":
        rootpass => "${puppetmaster::dbrootpw}";
    }
  }
}

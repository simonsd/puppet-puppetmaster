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
  include '::puppet'
  include '::iptables'
  include '::repos'
 
  class {
    'puppetmaster::repos':;
    'puppetmaster::packages':
      require => Class['puppetmaster::repos'];
    'puppetmaster::config':
      require => Class['puppetmaster::packages'];
    'puppetmaster::service':
      require => Class['puppetmaster::config'];
  }

  if $puppetmaster::storeconfigs == 'true' {
    class {
      "${puppetmaster::dbadapter}":
        rootpass => "${puppetmaster::dbrootpw}";
    }
  }
}

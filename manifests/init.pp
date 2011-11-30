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
  $cert_commonname = 'puppetmaster',
  $cert_altnames = [],
  $cert_country,
  $cert_basedir = '/var/lib/puppet/ssl',
  $cert_owner = 'puppet',
  $autosign = 'false'
){
  include '::puppet'
  include '::iptables'
  include '::repos'
  include '::openssl'
  include '::openssl::genx509'
 
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

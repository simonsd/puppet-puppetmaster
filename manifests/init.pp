import 'classes/*.pp'
import 'definitions/*.pp'

class puppetmaster (
  $dbname = 'puppet',
  $dbuser = 'puppet',
  $dbpassword,
  $dbhost = 'localhost',
  $dbadapter = 'mysql',
  $dbrootpw,
  $dbsocket = $::operatingsystem ? {
    default => '/var/lib/mysql/mysql.sock',
    archlinux => '/var/run/mysqld/mysqld.sock',
  },
  $storeconfigs = 'false',
  $cert_commonname = 'puppetmaster',
  $cert_altnames = [],
  $cert_organisation,
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
    'puppetmaster::storeconfigs':
      require => Class['puppetmaster::packages'];
    'puppetmaster::environments':
      require => Class['puppetmaster::storeconfigs'];
    'puppetmaster::config':
      require => Class['puppetmaster::environments'];
    'puppetmaster::passenger':
      require => Class['puppetmaster::config'];
    'puppetmaster::service':
      require => Class['puppetmaster::config'];
  }
}

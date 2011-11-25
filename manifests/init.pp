import 'classes/*.pp'

class puppetmaster (
  $autosign = 'no'
){
  include puppet
 
  class {
    'puppetmaster::packages':;
    'puppetmaster::config':;
    'puppetmaster::service':;
  }
}

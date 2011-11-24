import 'classes/*.pp'

class puppetmaster {
  include puppet
 
  class {
    'puppetmaster::packages':;
    'puppetmaster::config':;
    'puppetmaster::service':;
  }
}

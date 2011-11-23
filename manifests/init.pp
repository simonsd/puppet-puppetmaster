import 'classes/*.pp'

class puppetmaster {
  class {
    'puppetmaster::packages':;
    'puppetmaster::config':;
  }
}

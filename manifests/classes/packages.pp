class puppetmaster::packages {
  @package {
    'puppetmaster':
      name => $::operatingsystem ? {
        default => 'puppet-server',
        archlinux => undef,
      };
  }

  if $::operatingsystem != 'archlinux' {
    realize(Package['puppetmaster'])
  }

  package {
    'rubygem-mysql':
      name => $::operatingsystem ? {
        default => 'ruby-mysql',
        archlinux => 'mysql-ruby',
      };
    'activerecord':
# anything higher causes 'stack level too deep' errors on a puppetmaster. confirmed bug.
      ensure => '3.0.10',
      provider => gem;
  }
}

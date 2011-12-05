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
      provider => gem;
  }
}

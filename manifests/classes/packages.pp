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
}

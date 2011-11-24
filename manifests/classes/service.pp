class puppetmaster::service {
  service {
    'puppetmaster':
      ensure => running,
      enable => true,
      hasstatus => $::operatingsystem ? {
        default => undef,
        archlinux => false,
      },
      path => $::operatingsystem ? {
        default => undef,
        archlinux => '/etc/rc.d',
      };
  }
}

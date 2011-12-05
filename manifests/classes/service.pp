class puppetmaster::service {
  service {
    'puppetmaster':
      ensure => $puppetmaster::frontend ? {
        default => running,
        passenger => stopped,
      },
      enable => $puppetmaster::frontend ? {
        default => true,
        passenger => false,
      },
      hasstatus => $::operatingsystem ? {
        default => undef,
        archlinux => false,
      },
      path => $::operatingsystem ? {
        default => undef,
        archlinux => '/etc/rc.d',
      },
      require => Class['puppetmaster::config'];
  }
}

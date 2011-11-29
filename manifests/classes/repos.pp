class puppetmaster::repos {
  if $::operatingsystem == 'centos' {
    realize(Yumrepo['puppetlabs'])
  }
}

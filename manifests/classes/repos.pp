class puppetmaster::repos {
  if $::operatingsystem == 'centos' {
    realize(Yumrepo['puppetlabs', 'epel'], File['epel-gpg-key'])
  }
}

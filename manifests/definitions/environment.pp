define puppetmaster::environment (
  $provider = 'git',
  $url = '',
  $branch = 'master',
  $basedir = '/etc/puppet/environments'
){
  file {
    "${basedir}/${name}":
      ensure => directory,
      owner => root,
      group => root,
      mode => 0644;

    "${basedir}/${name}/manifests":
      ensure => directory,
      owner => root,
      group => root,
      mode => 0644,
      require => File["${basedir}/${name}"];

    "${basedir}/${name}/modules":
      ensure => directory,
      owner => root,
      group => root,
      mode => 0644,
      require => File["${basedir}/${name}"];
  }

  if $url != '' {
    case $provider {
      'git': {
        exec {
          "git clone ${url} ${branch} ${basedir}/${name}",
            before => File["${basedir}/${name}"];
        }
      }
      default: {
        fail "Unknown provider or not implemented yet: ${provider}"
      }
    }
  }
}

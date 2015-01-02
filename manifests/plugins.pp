define ohmyzsh::plugins(
  $plugins = 'git',
) {

  if $name == 'root' {
    $home = '/root'
  } else {
    $home = "${ohmyzsh::params::home}/${name}"
  }

  if $name {
    file_line { "${name}-${plugins}-install":
      path    => "${home}/.zshrc",
      line    => "plugins=(${plugins})",
      match   => '^plugins=',
      require => Ohmyzsh::Install[$name]
    }
  }

}

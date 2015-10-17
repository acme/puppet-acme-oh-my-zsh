class ohmyzsh::params {
  case $::operatingsystem {
    /(?i:FreeBSD)/: {
      $zsh = '/usr/local/bin/zsh'
      $home = '/home'
    }
    default: {
      $zsh = '/usr/bin/zsh'
      $home = '/home'
    }
  }
}

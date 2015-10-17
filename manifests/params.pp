class ohmyzsh::params {
  case $::operatingsystem {
    /(?i:FreeBSD)/: {
      $zsh = '/usr/local/bin/zsh'
      $home = '/home'
    }
    /(?i:Darwin)/: {
      $zsh = '/bin/zsh'
      $home = '/Users'
    }
    default: {
      $zsh = '/usr/bin/zsh'
      $home = '/home'
    }
  }
}

# Parameters class for ohmyzsh
class ohmyzsh::params {

  case $::osfamily {
    'Redhat': {
      $zsh = '/bin/zsh'
    }
    default: {
      $zsh = '/usr/bin/zsh'
    }
  }

  $home = '/home'

}

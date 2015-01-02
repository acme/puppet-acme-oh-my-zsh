define ohmyzsh::fetch::theme (
  $user,
  $url = 'UNSET',
  $source = 'UNSET',
  $content = 'UNSET',
  $filename = 'UNSET',
) {

  validate_string($user, $url, $source, $content, $filename)

  if ($url == 'UNSET') and ($source == 'UNSET') and ($content == 'UNSET') {
    fail('No valid option set.')
  }

  if $user == 'root' {
    $home = '/root'
  } else {
    $home = "/home/${user}"
  }

  if $filename == 'UNSET' {
    $fullpath = "${home}/.oh-my-zsh/custom/themes/${name}"
  } else {
    $fullpath = "${home}/.oh-my-zsh/custom/themes/${filename}"
  }

  if $url != 'UNSET' {
    wget::fetch { "ohmyzsh::fetch-${user}-${name}":
      source      => $url,
      destination => $fullpath,
      user        => $user,
    }
  } elsif $source != 'UNSET' {
    file { $fullpath:
      ensure => present,
      source => $source,
      owner  => $user,
    }
  } elsif $content != 'UNSET' {
    file { $fullpath:
      ensure  => present,
      content => $content,
      owner   => $user,
    }
  }

}

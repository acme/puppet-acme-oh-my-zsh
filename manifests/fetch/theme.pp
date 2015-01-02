define ohmyzsh::fetch::theme (
  $filename,
  $url = 'UNSET',
  $source = 'UNSET',
  $content = 'UNSET',
  $filename = 'UNSET',
) {

  validate_string($filename, $url, $source, $content, $filename)

  if ($url == 'UNSET') and ($source == 'UNSET') and ($content == 'UNSET') {
    fail('No valid option set.')
  }

  if $name == 'root' {
    $home = '/root'
  } else {
    $home = "/home/${name}"
  }

  $fullpath = "${home}/.oh-my-zsh/custom/themes/${filename}"

  if $url != 'UNSET' {
    wget::fetch { "ohmyzsh::fetch-${name}-${filename}":
      source      => $url,
      destination => $fullpath,
      user        => $name,
    }
  } elsif $source != 'UNSET' {
    file { $fullpath:
      ensure => present,
      source => $source,
      owner  => $name,
    }
  } elsif $content != 'UNSET' {
    file { $fullpath:
      ensure  => present,
      content => $content,
      owner   => $name,
    }
  }

}

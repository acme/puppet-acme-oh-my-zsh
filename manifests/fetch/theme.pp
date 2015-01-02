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

  $themepath = "${home}/.oh-my-zsh/custom/themes"
  $fullpath = "${themepath}/${filename}"

  if ! defined(File[$themepath]) {
    file { $themepath:
      ensure  => directory,
      owner   => $name,
      require => Ohmyzsh::Install[$name],
    }
  }

  if $url != 'UNSET' {
    wget::fetch { "ohmyzsh::fetch-${name}-${filename}":
      source      => $url,
      destination => $fullpath,
      user        => $name,
      require     => File[$themepath],
    }
  } elsif $source != 'UNSET' {
    file { $fullpath:
      ensure  => present,
      source  => $source,
      owner   => $name,
      require => File[$themepath],
    }
  } elsif $content != 'UNSET' {
    file { $fullpath:
      ensure  => present,
      content => $content,
      owner   => $name,
      require => File[$themepath],
    }
  }

}
